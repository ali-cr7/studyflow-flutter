import 'package:isar/isar.dart';
import 'package:study_planner/shared/data/database/collections/study_session_collection.dart';
import 'package:study_planner/shared/data/repositories/mappers/study_session_mapper.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';

class StudySessionRepositoryImpl implements StudySessionRepository {
  StudySessionRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<List<StudySession>> getAll() async {
    final collections = await _isar.studySessionCollections
        .where()
        .sortByStartTimeDesc()
        .findAll();
    return collections.map(StudySessionMapper.toDomain).toList();
  }

  @override
  Future<StudySession?> getById(int id) async {
    final collection = await _isar.studySessionCollections.get(id);
    if (collection == null) return null;
    return StudySessionMapper.toDomain(collection);
  }

  @override
  Future<List<StudySession>> getBySubject(int subjectId) async {
    final collections = await _isar.studySessionCollections
        .filter()
        .subjectIdEqualTo(subjectId)
        .sortByStartTimeDesc()
        .findAll();
    return collections.map(StudySessionMapper.toDomain).toList();
  }

  @override
  Future<List<StudySession>> getByDateRange({
    required DateTime start,
    required DateTime end,
  }) async {
    final collections = await _isar.studySessionCollections
        .filter()
        .startTimeGreaterThan(start, include: true)
        .startTimeLessThan(end, include: true)
        .sortByStartTimeDesc()
        .findAll();
    return collections.map(StudySessionMapper.toDomain).toList();
  }

  @override
  Future<StudySession?> getActiveSession() async {
    final collection = await _isar.studySessionCollections
        .filter()
        .completedEqualTo(false)
        .endTimeIsNull()
        .findFirst();
    if (collection == null) return null;
    return StudySessionMapper.toDomain(collection);
  }

  @override
  Future<StudySession> save(StudySession session) async {
    final collection = StudySessionMapper.toCollection(session);
    await _isar.writeTxn(() async {
      await _isar.studySessionCollections.put(collection);
    });
    return StudySessionMapper.toDomain(collection);
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.studySessionCollections.delete(id);
    });
  }
}
