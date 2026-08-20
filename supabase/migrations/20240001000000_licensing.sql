-- =============================================================================
-- Study Planner — Licensing Migration
-- =============================================================================
-- Run this once in the Supabase SQL editor (or via supabase db push).
--
-- What this creates:
--   1. activation_codes table        — stores hashed codes + redemption state
--   2. redeem_activation_code() RPC  — atomic one-time code consumption
--   3. Row Level Security policies   — clients can only call the RPC, never
--                                      read or write the table directly
-- =============================================================================


-- ---------------------------------------------------------------------------
-- 1. activation_codes table
-- ---------------------------------------------------------------------------

create table if not exists public.activation_codes (
    id            bigint generated always as identity primary key,

    -- SHA-256 hex digest of the normalised activation code (e.g. SP-7K4M-X92P).
    -- Plain-text codes are never stored.
    code_hash     text        not null unique,

    -- "student" for now; extend when new license tiers are needed.
    license_type  text        not null default 'student',

    -- available | activated | revoked
    status        text        not null default 'available'
                              check (status in ('available', 'activated', 'revoked')),

    -- Populated atomically by redeem_activation_code().
    activation_id uuid,
    activated_at  timestamptz,

    -- Admin metadata.
    created_at    timestamptz not null default now(),
    notes         text
);

comment on table  public.activation_codes           is 'One row per student activation code (hashed).';
comment on column public.activation_codes.code_hash is 'SHA-256 hex of upper-cased, trimmed activation code.';


-- ---------------------------------------------------------------------------
-- 2. Row Level Security — deny ALL direct client access
-- ---------------------------------------------------------------------------
-- The Flutter app must never be able to SELECT, INSERT, UPDATE, or DELETE
-- rows directly.  All access goes through the RPC below, which runs as the
-- postgres superuser (SECURITY DEFINER).
-- ---------------------------------------------------------------------------

alter table public.activation_codes enable row level security;

-- No RLS policies are created intentionally — the default-deny means anon
-- and authenticated roles have zero access to this table.


-- ---------------------------------------------------------------------------
-- 3. redeem_activation_code(p_code_hash text) — atomic RPC
-- ---------------------------------------------------------------------------
-- Called by the Flutter client with the SHA-256 hash of the code the student
-- typed.  Returns a JSON object; never raises an exception to the client.
--
-- Return shapes:
--   {"status": "success",      "activation_id": "<uuid>", "activated_at": "<iso8601>"}
--   {"status": "invalid_code"}
--   {"status": "already_used"}
--
-- Atomicity:
--   Uses SELECT … FOR UPDATE SKIP LOCKED inside an implicit transaction so
--   that two simultaneous requests for the same code cannot both succeed.
--   The second request finds the row already locked by the first, skips it
--   (finds no row), and returns invalid_code — harmless and correct.
-- ---------------------------------------------------------------------------

create or replace function public.redeem_activation_code(p_code_hash text)
returns json
language plpgsql
security definer          -- runs as postgres, bypasses RLS
set search_path = public  -- pin search path to prevent hijacking
as $$
declare
    v_row   public.activation_codes%rowtype;
    v_id    uuid := gen_random_uuid();
    v_now   timestamptz := now();
begin
    -- Lock the matching row exclusively; skip if another transaction already
    -- holds a lock (concurrent redemption attempt).
    select *
    into   v_row
    from   public.activation_codes
    where  code_hash = p_code_hash
    for    update skip locked;

    -- No row found (or row was locked by a concurrent transaction).
    if not found then
        -- Check whether the code exists at all (without locking).
        if exists (
            select 1 from public.activation_codes where code_hash = p_code_hash
        ) then
            -- Row exists but was locked → concurrent redemption won the race.
            return json_build_object('status', 'already_used');
        end if;
        return json_build_object('status', 'invalid_code');
    end if;

    -- Code found but already consumed or revoked.
    if v_row.status <> 'available' then
        return json_build_object('status', 'already_used');
    end if;

    -- Atomically mark as activated.
    update public.activation_codes
    set    status        = 'activated',
           activation_id = v_id,
           activated_at  = v_now
    where  id = v_row.id;

    return json_build_object(
        'status',        'success',
        'activation_id', v_id,
        'activated_at',  v_now
    );
end;
$$;

-- Allow the anon role (Flutter app with anonKey) to call the function.
grant execute on function public.redeem_activation_code(text) to anon;

-- Revoke direct table access from all roles just to be safe.
revoke all on public.activation_codes from anon, authenticated;


-- ---------------------------------------------------------------------------
-- 4. Helpful admin views (read-only, not exposed to the client)
-- ---------------------------------------------------------------------------

create or replace view public.activation_summary as
select
    status,
    license_type,
    count(*)                                    as total,
    count(*) filter (where status = 'available')  as available,
    count(*) filter (where status = 'activated')  as activated,
    count(*) filter (where status = 'revoked')    as revoked
from public.activation_codes
group by status, license_type;

comment on view public.activation_summary is
    'Quick count of code statuses per license type — admin use only.';
