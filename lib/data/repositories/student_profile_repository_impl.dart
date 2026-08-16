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
    try {
      final collection = await _isar.studentProfileCollections.get(
        DatabaseConstants.singletonId,
      );
      if (collection == null) return null;
      return StudentProfileMapper.toDomain(collection);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveProfile(StudentProfile profile) async {
    try {
      final collection = StudentProfileMapper.toCollection(profile);
      await _isar.writeTxn(() async {
        await _isar.studentProfileCollections.put(collection);
      });
    } catch (_) {
      return;
    }
  }

  @override
  Future<bool> hasProfile() async {
    try {
      return _isar.studentProfileCollections.getSync(
            DatabaseConstants.singletonId,
          ) !=
          null;
    } catch (_) {
      return false;
    }
  }
}
