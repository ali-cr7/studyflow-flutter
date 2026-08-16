import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/enums/app_theme_mode.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

class _FakeSettingsRepository implements AppSettingsRepository {
  _FakeSettingsRepository(this._settings);

  AppSettings _settings;

  @override
  Future<AppSettings> getSettings() async => _settings;

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
  }
}

class _FakeProfileRepository implements StudentProfileRepository {
  _FakeProfileRepository(this._profile);

  StudentProfile? _profile;

  @override
  Future<StudentProfile?> getProfile() async => _profile;

  @override
  Future<void> saveProfile(StudentProfile profile) async {
    _profile = profile;
  }

  @override
  Future<bool> hasProfile() async => _profile != null;
}

void main() {
  group('SettingsCubit', () {
    test('loads saved settings and updates theme and focus sound', () async {
      final settingsRepository = _FakeSettingsRepository(
        AppSettings.defaults().copyWith(
          theme: AppThemeMode.light,
          focusSound: FocusSoundMode.rain,
        ),
      );
      final profileRepository = _FakeProfileRepository(
        const StudentProfile(
          id: 1,
          name: 'Amina',
          grade: 'Grade 9',
          dailyGoalMinutes: 120,
          wakeUpTime: DayTime(hour: 7, minute: 0),
          sleepTime: DayTime(hour: 21, minute: 30),
          preferredSessionDuration: 25,
        ),
      );

      final cubit = SettingsCubit(
        profileRepository: profileRepository,
        settingsRepository: settingsRepository,
      );

      await cubit.loadSettings();

      expect(cubit.state.profile?.name, 'Amina');
      expect(cubit.state.settings.theme, AppThemeMode.light);
      expect(cubit.state.settings.focusSound, FocusSoundMode.rain);

      await cubit.updateTheme(AppThemeMode.dark);
      await cubit.updateFocusSound(FocusSoundMode.ocean);
      await cubit.updateStudyDuration(45);
      await cubit.updateBreakDuration(10);

      expect(cubit.state.settings.theme, AppThemeMode.dark);
      expect(cubit.state.settings.focusSound, FocusSoundMode.ocean);
      expect(cubit.state.settings.studyDuration, 45);
      expect(cubit.state.settings.breakDuration, 10);
      expect(settingsRepository._settings.theme, AppThemeMode.dark);
      expect(settingsRepository._settings.focusSound, FocusSoundMode.ocean);
      expect(settingsRepository._settings.studyDuration, 45);
      expect(settingsRepository._settings.breakDuration, 10);
    });
  });
}
