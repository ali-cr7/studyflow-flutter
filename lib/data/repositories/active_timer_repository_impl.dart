import 'package:isar/isar.dart';
import 'package:study_planner/data/database/collections/active_timer_collection.dart';
import 'package:study_planner/data/repositories/mappers/active_timer_mapper.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
import 'package:study_planner/shared/domain/repositories/active_timer_repository.dart';

class ActiveTimerRepositoryImpl implements ActiveTimerRepository {
  ActiveTimerRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<ActiveTimerState?> getActiveTimer() async {
    final collection = await _isar.activeTimerCollections.get(
      ActiveTimerState.singletonId,
    );
    if (collection == null) return null;
    return ActiveTimerMapper.toDomain(collection);
  }

  @override
  Future<ActiveTimerState> save(ActiveTimerState state) async {
    final collection = ActiveTimerMapper.toCollection(
      state.copyWith(
        id: ActiveTimerState.singletonId,
        updatedAt: DateTime.now(),
      ),
    );
    await _isar.writeTxn(() async {
      await _isar.activeTimerCollections.put(collection);
    });
    return ActiveTimerMapper.toDomain(collection);
  }

  @override
  Future<void> clear() async {
    await _isar.writeTxn(() async {
      await _isar.activeTimerCollections.delete(ActiveTimerState.singletonId);
    });
  }
}
