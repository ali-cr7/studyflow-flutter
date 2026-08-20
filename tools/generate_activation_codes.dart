// =============================================================================
// Study Planner — Activation Code Generator
// =============================================================================
//
// USAGE
//   dart run tools/generate_activation_codes.dart [count]
//
//   count  Number of codes to generate (default: 200)
//
// EXAMPLES
//   dart run tools/generate_activation_codes.dart
//   dart run tools/generate_activation_codes.dart 50
//
// OUTPUT
//   1. Prints each plain-text code to stdout (for distributing to students).
//   2. Writes a ready-to-paste SQL INSERT into  tools/output/codes_insert.sql
//      that you run once in the Supabase SQL editor to load the hashed codes.
//
// FORMAT
//   SP-XXXX-XXXX
//   where X is drawn from an unambiguous alphabet that avoids look-alike chars:
//   0 O → only O kept;  1 I l → only the digit 1 kept;  5 S → only S kept.
//   Alphabet: 2 3 4 6 7 8 9 A B C D E F G H J K M N P Q R S T U V W X Y Z
//   (29 characters → 29^4 × 29^4 ≈ 707 billion unique combinations)
//
// SECURITY
//   Uses Dart's Random.secure() which is backed by the OS CSPRNG.
//   The script never stores plain-text codes — only their SHA-256 hashes go
//   into the SQL file.
//
// IMPORTANT
//   Do NOT commit  tools/output/codes_insert.sql  to version control.
//   The file contains codes that will be distributed to students; treat it
//   as a secret until it has been loaded into Supabase.
// =============================================================================

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';

// Unambiguous character set — easy to read, type, and speak aloud.
const _alphabet = '23456789ABCDEFGHJKMNPQRSTUVWXYZ';

void main(List<String> args) {
  final count = args.isNotEmpty ? (int.tryParse(args.first) ?? 200) : 200;

  if (count <= 0 || count > 10000) {
    stderr.writeln('Count must be between 1 and 10 000.');
    exit(1);
  }

  final rng = Random.secure();
  final codes = <String>{};

  // Generate unique codes.
  while (codes.length < count) {
    codes.add(_generateCode(rng));
  }

  final codeList = codes.toList();

  // ── stdout: plain-text codes for distribution ──────────────────────────
  stdout.writeln('Generated $count activation codes:');
  stdout.writeln('─' * 20);
  for (final code in codeList) {
    stdout.writeln(code);
  }
  stdout.writeln('─' * 20);

  // ── SQL file: hashed codes for Supabase ───────────────────────────────
  final outputDir = Directory('tools/output');
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);

  final sqlFile = File('tools/output/codes_insert.sql');
  final buf = StringBuffer();

  buf.writeln('-- =================================================');
  buf.writeln('-- Study Planner — Activation Codes');
  buf.writeln('-- Generated: ${DateTime.now().toIso8601String()}');
  buf.writeln('-- Count: $count');
  buf.writeln('--');
  buf.writeln('-- Run this once in the Supabase SQL editor.');
  buf.writeln('-- DO NOT commit this file to version control.');
  buf.writeln('-- =================================================');
  buf.writeln();
  buf.writeln('insert into public.activation_codes (code_hash, license_type, status)');
  buf.writeln('values');

  for (var i = 0; i < codeList.length; i++) {
    final hash = _sha256(codeList[i]);
    final comma = i < codeList.length - 1 ? ',' : ';';
    buf.writeln("  ('$hash', 'student', 'available')$comma");
  }

  buf.writeln();
  buf.writeln('-- Verify:');
  buf.writeln('-- select count(*) from public.activation_codes where status = \'available\';');

  sqlFile.writeAsStringSync(buf.toString());

  stdout.writeln();
  stdout.writeln('SQL insert file written to: ${sqlFile.path}');
  stdout.writeln(
    'Load it into Supabase and then DELETE the file — '
    'do NOT commit it to git.',
  );
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _generateCode(Random rng) {
  String segment(int len) => List.generate(
        len,
        (_) => _alphabet[rng.nextInt(_alphabet.length)],
      ).join();

  return 'SP-${segment(4)}-${segment(4)}';
}

String _sha256(String code) {
  // Must match SupabaseActivationDataSource.hashCode() exactly:
  // normalise (trim + uppercase) then SHA-256.
  final normalised = code.trim().toUpperCase();
  return sha256.convert(utf8.encode(normalised)).toString();
}
