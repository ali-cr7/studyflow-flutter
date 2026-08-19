import 'package:study_planner/shared/domain/entities/active_timer_state.dart';

abstract class ActiveTimerRepository {
  Future<ActiveTimerState?> getActiveTimer();

  Future<ActiveTimerState> save(ActiveTimerState state);

  Future<void> clear();
}
