import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:study_planner/shared/domain/repositories/app_settings_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required StudentProfileRepository profileRepository,
    required AppSettingsRepository settingsRepository,
  })  : _profileRepository = profileRepository,
        _settingsRepository = settingsRepository,
        super(const DashboardState.loading());

  final StudentProfileRepository _profileRepository;
  final AppSettingsRepository _settingsRepository;

  /// Refreshes the dashboard data by reloading from repositories
  void refresh() => loadDashboard();

  Future<void> loadDashboard() async {
    emit(const DashboardState.loading());

    try {
      final profile = await _profileRepository.getProfile();
      if (profile == null) {
        emit(const DashboardState.empty());
        return;
      }

      final settings = await _settingsRepository.getSettings();
      emit(DashboardState.loaded(profile: profile, settings: settings));
    } catch (_) {
      emit(const DashboardState.failure(
        'Could not load your dashboard. Please try again.',
      ));
    }
  }
}
