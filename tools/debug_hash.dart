// Quick diagnostic tool — run with:
//   dart run tools/debug_hash.dart SP-V3YC-8DNN
//
// It prints exactly what hash the app sends to Supabase so you can verify
// it matches a row in your activation_codes table.

import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage: dart run tools/debug_hash.dart <code>');
    stderr.writeln('Example: dart run tools/debug_hash.dart SP-V3YC-8DNN');
    exit(1);
  }

  final raw = args.join(' '); // handles accidental spaces if quoted
  final normalised = raw.trim().toUpperCase().replaceAll(RegExp(r'-+'), '-');
  final hash = sha256.convert(utf8.encode(normalised)).toString();

  stdout.writeln('');
  stdout.writeln('Input    : $raw');
  stdout.writeln('Normalised: $normalised');
  stdout.writeln('SHA-256  : $hash');
  stdout.writeln('');
  stdout.writeln('--- Supabase SQL to verify ---');
  stdout.writeln("select * from activation_codes where code_hash = '$hash';");
  stdout.writeln('');
  stdout.writeln('--- Supabase SQL to redeem directly ---');
  stdout.writeln("select redeem_activation_code('$hash');");
}
