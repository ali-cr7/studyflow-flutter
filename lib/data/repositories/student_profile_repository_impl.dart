import 'package:isar/isar.dart';
import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/data/database/collections/student_profile_collection.dart';
import 'package:study_planner/data/repositories/mappers/student_profile_mapper.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

class StudentProfileRepositoryImpl implements StudentProfileRepository {
  StudentProfileRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<StudentProfile?> getProfile() async {
    final collection = await _isar.studentProfileCollections.get(
      DatabaseConstants.singletonId,
    );
    if (collection == null) return null;
    return StudentProfileMapper.toDomain(collection);
  }

  @override
  Future<void> saveProfile(StudentProfile profile) async {
    final collection = StudentProfileMapper.toCollection(profile);
    await _isar.writeTxn(() async {
      await _isar.studentProfileCollections.put(collection);
    });
  }

  @override
  Future<bool> hasProfile() async {
    return _isar.studentProfileCollections.getSync(
          DatabaseConstants.singletonId,
        ) !=
        null;
  }
}
