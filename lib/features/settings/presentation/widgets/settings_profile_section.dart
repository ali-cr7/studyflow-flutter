import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_state.dart';

class SettingsProfileSection extends StatelessWidget {
  const SettingsProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: profile?.name ?? '',
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) async {
                    await cubit.updateProfile(name: value.trim());
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: profile?.grade ?? '',
                  decoration: const InputDecoration(labelText: 'Grade'),
                  onChanged: (value) async {
                    await cubit.updateProfile(grade: value.trim());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
