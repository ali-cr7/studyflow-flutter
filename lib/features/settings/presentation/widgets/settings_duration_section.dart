import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class SettingsDurationSection extends StatelessWidget {
  const SettingsDurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SettingsCubit>();
    final settings = context.watch<SettingsCubit>().state.settings;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.sessionDefaults,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [25, 45, 60].map((minutes) {
                final selected = settings.studyDuration == minutes;
                return ChoiceChip(
                  label: Text('$minutes ${l10n.min}'),
                  selected: selected,
                  onSelected: (_) async {
                    await cubit.updateStudyDuration(minutes);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.breakDefaults,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [5, 10, 15, 20].map((minutes) {
                final selected = settings.breakDuration == minutes;
                return ChoiceChip(
                  label: Text('$minutes ${l10n.min}'),
                  selected: selected,
                  onSelected: (_) async {
                    await cubit.updateBreakDuration(minutes);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
