part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}


final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  HistoryLoaded({
    required this.month,
    required this.days,
  });

  final DateTime month;
  final List<HistoryDay> days;

  int get totalSessions {
    return days.fold(
      0,
      (sum, day) => sum + day.completedSessions,
    );
  }

  int get activeDays {
    return days.length;
  }

  int get totalSeconds {
    return days.fold(
      0,
      (sum, day) => sum + day.totalSeconds,
    );
  }
}

final class HistoryError extends HistoryState {
  HistoryError(this.message);

  final String message;
}