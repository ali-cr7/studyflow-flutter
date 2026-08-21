import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/core/utils/date_utils.dart';
import 'package:study_planner/shared/domain/entities/daily_plan.dart';
import 'package:study_planner/shared/domain/entities/planned_subject.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/daily_plan_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

part 'daily_plan_state.dart';

class DailyPlanCubit extends Cubit<DailyPlanState> {
  DailyPlanCubit({
    required DailyPlanRepository dailyPlanRepository,
    required SubjectRepository subjectRepository,
    required StudentProfileRepository profileRepository,
  }) : _dailyPlanRepository = dailyPlanRepository,
       _subjectRepository = subjectRepository,
       _profileRepository = profileRepository,
       super(DailyPlanInitial());

  final DailyPlanRepository _dailyPlanRepository;
  final SubjectRepository _subjectRepository;
  final StudentProfileRepository _profileRepository;
  DateTime _selectedDate = normalizeToLocalDate(DateTime.now());

  Future<void> loadPlanForDate(DateTime date) async {
    _selectedDate = normalizeToLocalDate(date);
    emit(DailyPlanLoading());

    try {
      final profile = await _profileRepository.getProfile();
      final sessionDurationMinutes = profile?.preferredSessionDuration ?? 25;
      final plan = await _dailyPlanRepository.getOrCreateForDate(_selectedDate);
      final allSubjects = await _subjectRepository.getAll();
      final subjectMap = {
        for (final subject in allSubjects) subject.id: subject,
      };

      emit(
        DailyPlanLoaded(
          date: _selectedDate,
          plan: plan,
          availableSubjects: List.unmodifiable(
            allSubjects
                .where(
                  (subject) => !plan.subjects.any(
                    (item) => item.subjectId == subject.id,
                  ),
                )
                .toList(growable: false),
          ),
          subjectsById: Map<int, Subject>.unmodifiable(subjectMap),
          sessionDurationMinutes: sessionDurationMinutes,
        ),
      );
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }

  Future<void> addPlannedSubject({
    required int subjectId,
    required int sessionCount,
  }) async {
    final currentState = state;
    if (currentState is! DailyPlanLoaded) return;

    final subject = currentState.subjectsById[subjectId];
    if (subject == null) return;

    final safeSessionCount = sessionCount.clamp(1, 12);
    final newSessions = List<PlannedSubject>.generate(
      safeSessionCount,
      (index) => PlannedSubject(
        id: 0,
        dailyPlanId: currentState.plan.id,
        subjectId: subjectId,
        plannedMinutes: currentState.sessionDurationMinutes,
        priority: 1,
        order: currentState.plan.subjects.length + index,
        completed: false,
      ),
    );

    final nextPlan = currentState.plan.copyWith(
      subjects: [...currentState.plan.subjects, ...newSessions],
    );

    try {
      await _dailyPlanRepository.save(nextPlan);
      await loadPlanForDate(_selectedDate);
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }

  Future<void> togglePlannedSubject(PlannedSubject plannedSubject) async {
    try {
      await _dailyPlanRepository.updatePlannedSubject(
        plannedSubject.copyWith(completed: !plannedSubject.completed),
      );
      await loadPlanForDate(_selectedDate);
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }

  Future<void> updateMinutes(PlannedSubject plannedSubject, int minutes) async {
    if (minutes <= 0) return;

    try {
      await _dailyPlanRepository.updatePlannedSubject(
        plannedSubject.copyWith(plannedMinutes: minutes),
      );
      await loadPlanForDate(_selectedDate);
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }

  Future<void> deletePlannedSubject(int plannedSubjectId) async {
    try {
      await _dailyPlanRepository.deletePlannedSubject(plannedSubjectId);
      await loadPlanForDate(_selectedDate);
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }

  Future<void> reorderPlannedSubjects(
    List<int> orderedPlannedSubjectIds,
  ) async {
    try {
      await _dailyPlanRepository.reorderPlannedSubjects(
        orderedPlannedSubjectIds,
      );
      await loadPlanForDate(_selectedDate);
    } catch (e) {
      emit(DailyPlanError(e.toString()));
    }
  }
}
