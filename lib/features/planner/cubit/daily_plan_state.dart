part of 'daily_plan_cubit.dart';

sealed class DailyPlanState {}

final class DailyPlanInitial extends DailyPlanState {}

final class DailyPlanLoading extends DailyPlanState {}

final class DailyPlanLoaded extends DailyPlanState {
  DailyPlanLoaded({
    required this.date,
    required this.plan,
    required this.availableSubjects,
    required this.subjectsById,
    required this.sessionDurationMinutes,
  });

  final DateTime date;
  final DailyPlan plan;
  final List<Subject> availableSubjects;
  final Map<int, Subject> subjectsById;
  final int sessionDurationMinutes;
}

final class DailyPlanError extends DailyPlanState {
  DailyPlanError(this.message);

  final String message;
}
