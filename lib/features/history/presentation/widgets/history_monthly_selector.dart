import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/history/presentation/cubit/history_cubit.dart';

class HistoryMonthSelector extends StatelessWidget {
  const HistoryMonthSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.sfColors;

    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is! HistoryLoaded) {
          return const SizedBox(
            height: 52,
          );
        }

        final month = state.month;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(
              AppColors.radiusXl,
            ),
            border: Border.all(
              color: colors.border,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Previous month',
                onPressed: () {
                  context.read<HistoryCubit>().previousMonth();
                },
                icon: const Icon(
                  Icons.chevron_left_rounded,
                ),
              ),

              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _showMonthPicker(
                    context,
                    month,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          _monthName(month.month),
                          style: theme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${month.year}',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(
                            color: colors.mutedForeground,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              IconButton(
                tooltip: 'Next month',
                onPressed: state.month.year ==
                            DateTime.now().year &&
                        state.month.month ==
                            DateTime.now().month
                    ? null
                    : context
                            .read<HistoryCubit>()
                            .canGoNext
                        ? () {
                            context
                                .read<HistoryCubit>()
                                .nextMonth();
                          }
                        : null,
                icon: const Icon(
                  Icons.chevron_right_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMonthPicker(
    BuildContext context,
    DateTime selectedMonth,
  ) async {
    final now = DateTime.now();

    final selected = await showDialog<DateTime>(
      context: context,
      builder: (dialogContext) {
        return _MonthPickerDialog(
          selectedMonth: selectedMonth,
          currentMonth: DateTime(
            now.year,
            now.month,
          ),
        );
      },
    );

    if (selected == null || !context.mounted) {
      return;
    }

    await context.read<HistoryCubit>().selectMonth(
          selected.year,
          selected.month,
        );
  }

  static String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}

class _MonthPickerDialog extends StatelessWidget {
  const _MonthPickerDialog({
    required this.selectedMonth,
    required this.currentMonth,
  });

  final DateTime selectedMonth;
  final DateTime currentMonth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Show the last 24 months.
    final months = <DateTime>[];

    for (var i = 0; i < 24; i++) {
      final month = DateTime(
        currentMonth.year,
        currentMonth.month - i,
      );

      months.add(month);
    }

    return AlertDialog(
      title: const Text('Select month'),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: ListView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            final month = months[index];

            final selected =
                month.year == selectedMonth.year &&
                month.month == selectedMonth.month;

            return ListTile(
              selected: selected,
              leading: Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
              ),
              title: Text(
                '${HistoryMonthSelector._monthName(month.month)} '
                '${month.year}',
              ),
              onTap: () {
                Navigator.of(context).pop(month);
              },
            );
          },
        ),
      ),
    );
  }
}