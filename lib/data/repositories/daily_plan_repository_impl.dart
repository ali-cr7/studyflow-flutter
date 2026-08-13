import 'package:isar/isar.dart';
import 'package:study_planner/core/utils/date_utils.dart';
import 'package:study_planner/data/database/collections/daily_plan_collection.dart';
import 'package:study_planner/data/database/collections/planned_subject_collection.dart';
import 'package:study_planner/data/repositories/mappers/daily_plan_mapper.dart';
import 'package:study_planner/data/repositories/mappers/planned_subject_mapper.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';

class DailyPlanRepositoryImpl implements DailyPlanRepository {
  DailyPlanRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<DailyPlan?> getByDate(DateTime date) async {
    final collection = await _isar.dailyPlanCollections.getByDate(
      normalizeToLocalDate(date),
    );
    if (collection == null) return null;
    return _assembleDailyPlan(collection);
  }

  @override
  Future<DailyPlan> getOrCreateForDate(DateTime date) async {
    final normalizedDate = normalizeToLocalDate(date);
    var collection = await _isar.dailyPlanCollections.getByDate(normalizedDate);

    if (collection == null) {
      collection = DailyPlanCollection()..date = normalizedDate;
      await _isar.writeTxn(() async {
        await _isar.dailyPlanCollections.put(collection!);
      });
    }

    return _assembleDailyPlan(collection);
  }

  @override
  Future<void> save(DailyPlan plan) async {
    final planCollection = DailyPlanMapper.toCollection(plan);

    await _isar.writeTxn(() async {
      await _isar.dailyPlanCollections.put(planCollection);
      final planId = planCollection.id;

      final existingRows = await _isar.plannedSubjectCollections
          .filter()
          .dailyPlanIdEqualTo(planId)
          .findAll();

      final incomingIds = plan.subjects
          .where((subject) => subject.id != 0)
          .map((subject) => subject.id)
          .toSet();

      for (final existing in existingRows) {
        if (!incomingIds.contains(existing.id)) {
          await _isar.plannedSubjectCollections.delete(existing.id);
        }
      }

      for (final subject in plan.subjects) {
        final row = PlannedSubjectMapper.toCollection(
          subject.copyWith(dailyPlanId: planId),
        );
        await _isar.plannedSubjectCollections.put(row);
      }
    });
  }

  @override
  Future<void> updatePlannedSubject(PlannedSubject plannedSubject) async {
    final row = PlannedSubjectMapper.toCollection(plannedSubject);
    await _isar.writeTxn(() async {
      await _isar.plannedSubjectCollections.put(row);
    });
  }

  @override
  Future<void> deletePlannedSubject(int plannedSubjectId) async {
    await _isar.writeTxn(() async {
      await _isar.plannedSubjectCollections.delete(plannedSubjectId);
    });
  }

  @override
  Future<void> reorderPlannedSubjects(
    List<int> orderedPlannedSubjectIds,
  ) async {
    await _isar.writeTxn(() async {
      for (var index = 0; index < orderedPlannedSubjectIds.length; index++) {
        final id = orderedPlannedSubjectIds[index];
        final row = await _isar.plannedSubjectCollections.get(id);
        if (row == null) continue;
        row.sortOrder = index;
        await _isar.plannedSubjectCollections.put(row);
      }
    });
  }

  Future<DailyPlan> _assembleDailyPlan(DailyPlanCollection collection) async {
    final plannedRows = await _isar.plannedSubjectCollections
        .filter()
        .dailyPlanIdEqualTo(collection.id)
        .sortBySortOrder()
        .findAll();

    return DailyPlanMapper.toDomain(
      collection,
      plannedRows.map(PlannedSubjectMapper.toDomain).toList(),
    );
  }
}
