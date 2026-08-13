import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class StepperIndicator extends StatelessWidget {
  const StepperIndicator({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final colors = context.sfColors;
    final activeColor = Theme.of(context).colorScheme.primary;
    return Row(
      children: List.generate(
        7,
        (index) => Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: index <= currentIndex ? activeColor : colors.muted,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}




