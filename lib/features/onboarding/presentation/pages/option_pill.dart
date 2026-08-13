import 'package:flutter/material.dart';

class OptionPill extends StatelessWidget {
  const OptionPill({super.key, 
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: scheme.primary,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: selected ? scheme.onPrimary : theme.colorScheme.onSurface,
      ),
      side: BorderSide(color: selected ? scheme.primary : theme.dividerColor),
      backgroundColor: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }
}
