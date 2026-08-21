import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';

import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';

class SettingsAppearanceSection extends StatelessWidget {
  const SettingsAppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final settings = context.watch<SettingsCubit>().state.settings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<AppThemeMode>(
              segments: const [
                // ButtonSegment(
                //   value: AppThemeMode.system,
                //   label: Text('System'),
                // ),
                ButtonSegment(value: AppThemeMode.light, label: Text('Light')),
                ButtonSegment(value: AppThemeMode.dark, label: Text('Dark')),
              ],
              selected: {settings.theme},
              onSelectionChanged: (selection) async {
                await cubit.updateTheme(selection.first);
              },
            ),
          ),
        ),
      ],
    );
  }
}
