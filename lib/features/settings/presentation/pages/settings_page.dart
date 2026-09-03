import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/widgets/application_drawer.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_state.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_appearance_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_duration_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_focus_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_language_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_profile_section.dart';
import 'package:study_planner/l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.tabIndexNotifier,
    required this.refreshNotifier,
  });

  final ValueNotifier<int> tabIndexNotifier;
  final ValueNotifier<int> refreshNotifier;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    widget.tabIndexNotifier.addListener(_onTabChanged);
    widget.refreshNotifier.addListener(_onRefreshRequested);
  }

  @override
  void dispose() {
    widget.tabIndexNotifier.removeListener(_onTabChanged);
    widget.refreshNotifier.removeListener(_onRefreshRequested);
    super.dispose();
  }

  void _onTabChanged() {
    if (widget.tabIndexNotifier.value == 5) {
      context.read<SettingsCubit>().refresh();
    }
  }

  void _onRefreshRequested() {
    if (widget.tabIndexNotifier.value == 5) {
      context.read<SettingsCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        return Scaffold(
          drawer: ApplicationDrawer(),
          appBar: AppBar(title: Text(l10n.settingsTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SettingsProfileSection(),
                  const SizedBox(height: 20),
                  const SettingsAppearanceSection(),
                  const SizedBox(height: 20),
                  const SettingsLanguageSection(),
                  const SizedBox(height: 20),
                  const SettingsFocusSection(),
                  const SizedBox(height: 20),
                  const SettingsDurationSection(),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}