import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/features/planner/cubit/daily_plan_cubit.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/entities/student_profile.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

void main() {
  group('DailyPlanCubit', () {
    test('loads the selected day and available subjects', () async {
      final date = DateTime(2026, 8, 14);
      final subject = Subject(
        id: 7,
        name: 'Math',
        color: 0xFF4C6FFF,
        icon: 'calculate',
      );
      final plan = DailyPlan(
        id: 1,
        date: date,
        subjects: [
          PlannedSubject(
            id: 11,
            dailyPlanId: 1,
            subjectId: subject.id,
            plannedMinutes: 45,
            priority: 1,
            order: 0,
            completed: false,
          ),
        ],
      );

      final cubit = DailyPlanCubit(
        dailyPlanRepository: _FakeDailyPlanRepository(plan),
        subjectRepository: _FakeSubjectRepository([subject]),
        profileRepository: _FakeStudentProfileRepository(
          const StudentProfile(
            id: 1,
            name: 'Ali',
            grade: '12',
            dailyGoalMinutes: 180,
            wakeUpTime: DayTime(hour: 7, minute: 0),
            sleepTime: DayTime(hour: 22, minute: 30),
            preferredSessionDuration: 25,
          ),
        ),
      );

      await cubit.loadPlanForDate(date);

      expect(cubit.state, isA<DailyPlanLoaded>());
      final state = cubit.state as DailyPlanLoaded;
      expect(state.plan.subjects.length, 1);
      expect(state.availableSubjects.length, 0);
      expect(state.subjectsById[subject.id]?.name, 'Math');
    });

    test(
      'creates one plan row per session when adding multiple sessions',
      () async {
        final date = DateTime(2026, 8, 14);
        final subject = Subject(
          id: 7,
          name: 'Math',
          color: 0xFF4C6FFF,
          icon: 'calculate',
        );
        final repository = _FakeDailyPlanRepository(
          DailyPlan(id: 1, date: date, subjects: const []),
        );
        final cubit = DailyPlanCubit(
          dailyPlanRepository: repository,
          subjectRepository: _FakeSubjectRepository([subject]),
          profileRepository: _FakeStudentProfileRepository(
            const StudentProfile(
              id: 1,
              name: 'Ali',
              grade: '12',
              dailyGoalMinutes: 180,
              wakeUpTime: DayTime(hour: 7, minute: 0),
              sleepTime: DayTime(hour: 22, minute: 30),
              preferredSessionDuration: 25,
            ),
          ),
        );

        await cubit.loadPlanForDate(date);
        await cubit.addPlannedSubject(subjectId: subject.id, sessionCount: 3);

        expect((cubit.state as DailyPlanLoaded).plan.subjects.length, 3);
        expect(
          (cubit.state as DailyPlanLoaded).plan.subjects.every(
            (item) => item.subjectId == subject.id,
          ),
          isTrue,
        );
        expect(
          (cubit.state as DailyPlanLoaded).plan.subjects.every(
            (item) => item.plannedMinutes == 25,
          ),
          isTrue,
        );
      },
    );

    test(
      'deletes only one session while leaving the others in place',
      () async {
        final date = DateTime(2026, 8, 14);
        final subject = Subject(
          id: 7,
          name: 'Math',
          color: 0xFF4C6FFF,
          icon: 'calculate',
        );
        final repository = _FakeDailyPlanRepository(
          DailyPlan(
            id: 1,
            date: date,
            subjects: [
              PlannedSubject(
                id: 11,
                dailyPlanId: 1,
                subjectId: subject.id,
                plannedMinutes: 25,
                priority: 1,
                order: 0,
                completed: false,
              ),
              PlannedSubject(
                id: 12,
                dailyPlanId: 1,
                subjectId: subject.id,
                plannedMinutes: 25,
                priority: 1,
                order: 1,
                completed: false,
              ),
              PlannedSubject(
                id: 13,
                dailyPlanId: 1,
                subjectId: subject.id,
                plannedMinutes: 25,
                priority: 1,
                order: 2,
                completed: false,
              ),
            ],
          ),
        );
        final cubit = DailyPlanCubit(
          dailyPlanRepository: repository,
          subjectRepository: _FakeSubjectRepository([subject]),
          profileRepository: _FakeStudentProfileRepository(
            const StudentProfile(
              id: 1,
              name: 'Ali',
              grade: '12',
              dailyGoalMinutes: 180,
              wakeUpTime: DayTime(hour: 7, minute: 0),
              sleepTime: DayTime(hour: 22, minute: 30),
              preferredSessionDuration: 25,
            ),
          ),
        );

        await cubit.loadPlanForDate(date);
        await cubit.deletePlannedSubject(12);

        final loaded = cubit.state as DailyPlanLoaded;
        expect(loaded.plan.subjects.length, 2);
        expect(
          loaded.plan.subjects.map((item) => item.id),
          containsAll([11, 13]),
        );
      },
    );
  });
}

class _FakeDailyPlanRepository implements DailyPlanRepository {
  _FakeDailyPlanRepository(this._plan);

  DailyPlan _plan;

  @override
  Future<DailyPlan?> getByDate(DateTime date) async => _plan;

  @override
  Future<DailyPlan> getOrCreateForDate(DateTime date) async => _plan;

  @override
  Future<void> save(DailyPlan plan) async => _plan = plan;

  @override
  Future<void> updatePlannedSubject(PlannedSubject plannedSubject) async {
    final index = _plan.subjects.indexWhere(
      (item) => item.id == plannedSubject.id,
    );
    if (index >= 0) {
      _plan = _plan.copyWith(
        subjects: List<PlannedSubject>.from(_plan.subjects)
          ..[index] = plannedSubject,
      );
    }
  }

  @override
  Future<void> deletePlannedSubject(int plannedSubjectId) async {
    _plan = _plan.copyWith(
      subjects: _plan.subjects
          .where((item) => item.id != plannedSubjectId)
          .toList(growable: false),
    );
  }

  @override
  Future<void> reorderPlannedSubjects(
    List<int> orderedPlannedSubjectIds,
  ) async {}
}

class _FakeStudentProfileRepository implements StudentProfileRepository {
  _FakeStudentProfileRepository(this._profile);

  final StudentProfile _profile;

  @override
  Future<StudentProfile?> getProfile() async => _profile;

  @override
  Future<void> saveProfile(StudentProfile profile) async {}

  @override
  Future<bool> hasProfile() async => true;
}

class _FakeSubjectRepository implements SubjectRepository {
  _FakeSubjectRepository(this._subjects);

  final List<Subject> _subjects;

  @override
  Future<List<Subject>> getAll() async => List.unmodifiable(_subjects);

  @override
  Future<Subject?> getById(int id) async {
    for (final subject in _subjects) {
      if (subject.id == id) {
        return subject;
      }
    }
    return null;
  }

  @override
  Future<Subject> save(Subject subject) async {
    _subjects.add(subject);
    return subject;
  }

  @override
  Future<void> delete(int id) async {
    _subjects.removeWhere((subject) => subject.id == id);
  }
}
