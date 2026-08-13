import 'package:study_planner/shared/domain/entities/student_profile.dart';

/// Contract for reading and writing the single student profile.
///
/// Cubits depend on this interface — never on Isar directly.
abstract class StudentProfileRepository {
  /// Returns the saved profile, or `null` before onboarding completes.
  Future<StudentProfile?> getProfile();

  /// Creates or replaces the singleton profile row.
  Future<void> saveProfile(StudentProfile profile);

  /// Whether onboarding has been completed at least once.
  Future<bool> hasProfile();
}
