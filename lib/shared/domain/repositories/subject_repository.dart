import 'package:study_planner/shared/domain/entities/subject.dart';

/// Contract for managing the student's subject catalog.
abstract class SubjectRepository {
  Future<List<Subject>> getAll();

  Future<Subject?> getById(int id);

  /// Persists a subject. Returns the subject with its database [Subject.id].
  Future<Subject> save(Subject subject);

  Future<void> delete(int id);
}
