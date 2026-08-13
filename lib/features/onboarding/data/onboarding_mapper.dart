import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';

/// Maps onboarding form state to domain entities before persistence.
abstract final class OnboardingMapper {
  static StudentProfile toStudentProfile(OnboardingState state) {
    return StudentProfile(
      id: DatabaseConstants.singletonId,
      name: state.name.trim(),
      grade: state.grade ?? 'Other',
      dailyGoalMinutes: state.currentDailyGoalMinutes,
      wakeUpTime: state.wakeUpTime,
      sleepTime: state.sleepTime,
      preferredSessionDuration: state.currentStudyMinutes,
    );
  }

  static AppSettings toAppSettings(OnboardingState state) {
    return AppSettings.defaults().copyWith(
      studyDuration: state.currentStudyMinutes,
      breakDuration: state.selectedBreakMinutes,
      notificationsEnabled: state.notificationEnabled,
    );
  }
}
