import 'package:study_planner/data/database/collections/active_timer_collection.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';

abstract final class ActiveTimerMapper {
  static ActiveTimerState toDomain(ActiveTimerCollection collection) {
    return ActiveTimerState(
      id: collection.id,
      phase: _phaseFromValue(collection.phase),
      subjectId: collection.subjectId,
      sessionId: collection.sessionId,
      startedAt: collection.startedAt,
      endsAt: collection.endsAt,
      accumulatedSeconds: collection.accumulatedSeconds,
      plannedDurationSeconds: collection.plannedDurationSeconds,
      createdAt: collection.createdAt,
      updatedAt: collection.updatedAt,
    );
  }

  static ActiveTimerCollection toCollection(ActiveTimerState state) {
    return ActiveTimerCollection()
      ..id = state.id
      ..phase = state.phase.name
      ..subjectId = state.subjectId
      ..sessionId = state.sessionId
      ..startedAt = state.startedAt
      ..endsAt = state.endsAt
      ..accumulatedSeconds = state.accumulatedSeconds
      ..plannedDurationSeconds = state.plannedDurationSeconds
      ..createdAt = state.createdAt
      ..updatedAt = state.updatedAt;
  }

  static ActiveTimerPhase _phaseFromValue(String value) {
    return ActiveTimerPhase.values.firstWhere(
      (phase) => phase.name == value,
      orElse: () => ActiveTimerPhase.idle,
    );
  }
}
