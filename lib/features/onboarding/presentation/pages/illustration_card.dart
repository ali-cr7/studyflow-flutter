import 'package:flutter/material.dart';
import 'package:study_planner/core/app_colors.dart';

class IllustrationCard extends StatelessWidget {
  const IllustrationCard({required this.colors});

  final StudyFlowColors colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 380),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.primaryLight,
              borderRadius: BorderRadius.circular(AppColors.radiusXl),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppColors.radiusLg,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF4C6FFF),
                            size: 64,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: colors.accentLight,
                        borderRadius: BorderRadius.circular(AppColors.radiusLg),
                      ),
                      child: const Icon(
                        Icons.timer_outlined,
                        color: Color(0xFFFF9F43),
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppColors.radiusLg,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '30 min',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppColors.radiusLg,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '2 subjects',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
