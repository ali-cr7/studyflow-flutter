import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/enums/app_language.dart';

class SettingsLanguageSection extends StatelessWidget {
  const SettingsLanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SettingsCubit>();
    final settings = context.watch<SettingsCubit>().state.settings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.language, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<AppLanguage>(
              segments: [
                ButtonSegment(
                  value: AppLanguage.en,
                  label: Text(l10n.languageEnglish),
                ),
                ButtonSegment(
                  value: AppLanguage.ar,
                  label: Text(l10n.languageArabic),
                ),
              ],
              selected: {settings.language},
              onSelectionChanged: (selection) async {
                await cubit.updateLanguage(selection.first);
              },
            ),
          ),
        ),
      ],
    );
  }
}