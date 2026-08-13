import 'package:study_planner/shared/domain/entities/app_settings.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';

enum DashboardStatus { loading, loaded, empty, failure }

class DashboardState {
  const DashboardState({
    required this.status,
    this.profile,
    this.settings,
    this.errorMessage,
  });

  const DashboardState.loading() : this(status: DashboardStatus.loading);

  const DashboardState.empty() : this(status: DashboardStatus.empty);

  const DashboardState.loaded({
    required StudentProfile profile,
    required AppSettings settings,
  }) : this(
          status: DashboardStatus.loaded,
          profile: profile,
          settings: settings,
        );

  const DashboardState.failure(String message)
      : this(status: DashboardStatus.failure, errorMessage: message);

  final DashboardStatus status;
  final StudentProfile? profile;
  final AppSettings? settings;
  final String? errorMessage;
}
