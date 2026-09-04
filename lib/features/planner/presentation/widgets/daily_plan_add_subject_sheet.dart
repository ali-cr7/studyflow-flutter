import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:study_planner/core/app_colors.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

class DailyPlanAddSubjectSheet extends StatefulWidget {
  const DailyPlanAddSubjectSheet({
    super.key,
    required this.availableSubjects,
    required this.sessionDurationMinutes,
  });

  final List<Subject> availableSubjects;
  final int sessionDurationMinutes;

  @override
  State<DailyPlanAddSubjectSheet> createState() =>
      _DailyPlanAddSubjectSheetState();
}

class _DailyPlanAddSubjectSheetState extends State<DailyPlanAddSubjectSheet> {
  late int pickedSubjectId;
  late final TextEditingController sessionsController;

  @override
  void initState() {
    super.initState();

    pickedSubjectId = widget.availableSubjects.first.id;
    sessionsController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    sessionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 52,
              height: 5,
              decoration: BoxDecoration(
                color: context.sfColors.muted,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            l10n.addToTodaysPlan,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<int>(
            value: pickedSubjectId,
            decoration: InputDecoration(
              labelText: l10n.subject,
              prefixIcon: const Icon(Icons.school_outlined),
            ),
            items: widget.availableSubjects
                .map(
                  (subject) => DropdownMenuItem<int>(
                    value: subject.id,
                    child: Text(subject.name, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => pickedSubjectId = value);
              }
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: sessionsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.sessions,
              prefixIcon: const Icon(Icons.event_available_outlined),
              helperText: l10n.sessionDurationHelper(
                widget.sessionDurationMinutes,
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                final cubit = context.read<DailyPlanCubit>();

                final sessions = int.tryParse(sessionsController.text) ?? 1;

                cubit.addPlannedSubject(
                  subjectId: pickedSubjectId,
                  sessionCount: sessions,
                );

                Navigator.of(context).pop();
              },
              child: Text(l10n.addSubject),
            ),
          ),
        ],
      ),
    );
  }
}
