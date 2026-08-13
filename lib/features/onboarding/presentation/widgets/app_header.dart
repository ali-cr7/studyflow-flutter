
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(
            Icons.auto_stories_outlined,
            size: 44,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 18),
        Text('StudyFlow', style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }
}
