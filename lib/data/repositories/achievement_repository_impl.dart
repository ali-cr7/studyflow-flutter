import 'package:isar/isar.dart';
import 'package:study_planner/data/database/collections/achievement_collection.dart';
import 'package:study_planner/data/repositories/mappers/achievement_mapper.dart';
import 'package:study_planner/shared/domain/entities/achievement.dart';
import 'package:study_planner/shared/domain/enums/achievement_type.dart';
import 'package:study_planner/shared/domain/repositories/achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  AchievementRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<List<Achievement>> getAll() async {
    final collections = await _isar.achievementCollections
        .where()
        .sortByUnlockedAtDesc()
        .findAll();
    return collections.map(AchievementMapper.toDomain).toList();
  }

  @override
  Future<Achievement?> getByType(AchievementType type) async {
    final collection = await _isar.achievementCollections
        .filter()
        .typeEqualTo(type)
        .findFirst();
    if (collection == null) return null;
    return AchievementMapper.toDomain(collection);
  }

  @override
  Future<bool> hasUnlocked(AchievementType type) async {
    final count = await _isar.achievementCollections
        .filter()
        .typeEqualTo(type)
        .count();
    return count > 0;
  }

  @override
  Future<Achievement> unlock(AchievementType type) async {
    final existing = await getByType(type);
    if (existing != null) return existing;

    final collection = AchievementMapper.toCollection(
      Achievement(
        id: 0,
        type: type,
        unlockedAt: DateTime.now(),
      ),
    );

    await _isar.writeTxn(() async {
      await _isar.achievementCollections.put(collection);
    });

    return AchievementMapper.toDomain(collection);
  }
}
