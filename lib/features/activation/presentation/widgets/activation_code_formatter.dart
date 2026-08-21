import 'package:flutter/services.dart';
// ─────────────────────────────────────────────────────────────────────────────
// Input formatter — auto-inserts dashes as the user types:
//   7  →  7
//   7K4M  →  7K4M
//   7K4MX  →  7K4M-X
//   SP7K4MX92P  →  SP-7K4M-X92P
// Strips non-alphanumeric characters and limits to 10 code chars + 2 dashes.
// ─────────────────────────────────────────────────────────────────────────────
class ActivationCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Strip everything except letters and digits, uppercase.
    final raw =
        newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

    // Limit to 10 meaningful characters (SP + 4 + 4).
    final clipped = raw.length > 10 ? raw.substring(0, 10) : raw;

    // Rebuild with dashes: SP-XXXX-XXXX
    final buffer = StringBuffer();
    for (var i = 0; i < clipped.length; i++) {
      if (i == 2 || i == 6) buffer.write('-');
      buffer.write(clipped[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}