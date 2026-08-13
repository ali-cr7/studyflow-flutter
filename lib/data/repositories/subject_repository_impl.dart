import 'package:isar/isar.dart';
import 'package:study_planner/data/database/collections/subject_collection.dart';
import 'package:study_planner/data/repositories/mappers/subject_mapper.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  SubjectRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<List<Subject>> getAll() async {
    final collections = await _isar.subjectCollections.where().sortByName().findAll();
    return collections.map(SubjectMapper.toDomain).toList();
  }

  @override
  Future<Subject?> getById(int id) async {
    final collection = await _isar.subjectCollections.get(id);
    if (collection == null) return null;
    return SubjectMapper.toDomain(collection);
  }

  @override
  Future<Subject> save(Subject subject) async {
    final collection = SubjectMapper.toCollection(subject);
    await _isar.writeTxn(() async {
      await _isar.subjectCollections.put(collection);
    });
    return SubjectMapper.toDomain(collection);
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.subjectCollections.delete(id);
    });
  }
}
