import 'package:flutter/material.dart';
import 'package:study_planner/features/onboarding/presentation/widgets/book_block.dart';

class Illustration extends StatelessWidget {
  const Illustration({super.key, required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 84,
                    height: 92,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.menu_book_outlined,
                      size: 42,
                      color: Color(0xFF4C6FFF),
                    ),
                  ),

                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF3E6),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.timer_outlined,
                      size: 36,
                      color: Color(0xFFFF9F43),
                    ),
                  ),
                ],
              ),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 22,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: scheme.primary.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              size: 30,
                              color: scheme.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Student at desk',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Books, focus, and time.',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.70),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.24),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: scheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  BookBlock(color: scheme.primary.withValues(alpha: 0.18)),
                  const SizedBox(width: 12),
                  BookBlock(color: const Color(0xFFFFF3E6)),
                  const SizedBox(width: 12),
                  BookBlock(color: scheme.secondary.withValues(alpha: 0.18)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
