import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';

class SettingsFocusSection extends StatelessWidget {
  const SettingsFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SettingsCubit>();
    final settings = context.watch<SettingsCubit>().state.settings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.focusSettings, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  value: settings.notificationsEnabled,
                  onChanged: cubit.updateNotifications,
                  title: Text(l10n.notifications),
                  subtitle: Text(l10n.notificationsSubtitle),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: settings.soundEnabled,
                  onChanged: cubit.updateSoundEffects,
                  title: Text(l10n.soundEffects),
                  subtitle: Text(l10n.soundEffectsSubtitle),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(l10n.focusSound),
                  subtitle: Text(settings.focusSound.label),
                  trailing: const Icon(Icons.music_note_rounded),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: FocusSoundMode.values.map((sound) {
                    final selected = sound == settings.focusSound;
                    return ChoiceChip(
                      label: Text(sound.label),
                      selected: selected,
                      onSelected: (_) async {
                        await cubit.updateFocusSound(sound);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
