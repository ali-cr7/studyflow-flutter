import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_state.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_appearance_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_duration_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_focus_section.dart';
import 'package:study_planner/features/settings/presentation/widgets/settings_profile_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SettingsProfileSection(),
                  const SizedBox(height: 20),
                  const SettingsAppearanceSection(),
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
