import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import 'package:study_planner/shared/domain/entities/history_day.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/study_session_repository.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';


part 'history_state.dart';
class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    required StudySessionRepository studySessionRepository,
    required SubjectRepository subjectRepository,
  })  : _studySessionRepository = studySessionRepository,
        _subjectRepository = subjectRepository,
        super(HistoryInitial());

  final StudySessionRepository _studySessionRepository;
  final SubjectRepository _subjectRepository;

  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  DateTime get selectedMonth => _selectedMonth;

  Future<void> loadCurrentMonth() async {
    await loadMonth(DateTime.now());
  }

  Future<void> loadMonth(DateTime month) async {
    emit(HistoryLoading());

    try {
      _selectedMonth = DateTime(
        month.year,
        month.month,
      );

      final start = DateTime(
        _selectedMonth.year,
        _selectedMonth.month,
        1,
      );

      // First moment of the next month.
      //
      // Using an exclusive end makes the date-range logic safer than
      // manually constructing 23:59:59.
      final end = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + 1,
        1,
      );

      final sessions = await _studySessionRepository.getByDateRange(
        start: start,
        end: end,
      );

      final subjects = await _subjectRepository.getAll();

      final subjectsById = {
        for (final subject in subjects) subject.id: subject,
      };

      final completedSessions = sessions
          .where((session) => session.completed)
          .toList();

      final groupedByDay = <DateTime, List<StudySession>>{};

      for (final session in completedSessions) {
        final day = DateTime(
          session.startTime.year,
          session.startTime.month,
          session.startTime.day,
        );

        groupedByDay.putIfAbsent(day, () => []).add(session);
      }

      final historyDays = groupedByDay.entries.map((entry) {
        final daySessions = entry.value;

        final subjectCounts = <String, int>{};

        for (final session in daySessions) {
          final subject = subjectsById[session.subjectId];

          final subjectName =
              subject?.name ?? 'Unknown subject';

          subjectCounts[subjectName] =
              (subjectCounts[subjectName] ?? 0) + 1;
        }

        final totalSeconds = daySessions.fold<int>(
          0,
          (sum, session) => sum + session.duration,
        );

        return HistoryDay(
          date: entry.key,
          completedSessions: daySessions.length,
          subjectCounts: subjectCounts,
          totalSeconds: totalSeconds,
        );
      }).toList();

      // Newest day first.
      historyDays.sort(
        (a, b) => b.date.compareTo(a.date),
      );

      emit(
        HistoryLoaded(
          month: _selectedMonth,
          days: historyDays,
        ),
      );
    } catch (error) {
      emit(
        HistoryError(error.toString()),
      );
    }
  }

  Future<void> previousMonth() async {
    final previous = DateTime(
      _selectedMonth.year,
      _selectedMonth.month - 1,
    );

    await loadMonth(previous);
  }

  Future<void> nextMonth() async {
    final now = DateTime.now();

    final next = DateTime(
      _selectedMonth.year,
      _selectedMonth.month + 1,
    );

    final currentMonth = DateTime(
      now.year,
      now.month,
    );

    // Don't allow the user to navigate into future months.
    if (next.isAfter(currentMonth)) {
      return;
    }

    await loadMonth(next);
  }

  Future<void> selectMonth(int year, int month) async {
    final now = DateTime.now();

    final selected = DateTime(
      year,
      month,
    );

    final currentMonth = DateTime(
      now.year,
      now.month,
    );

    if (selected.isAfter(currentMonth)) {
      return;
    }

    await loadMonth(selected);
  }

  bool get canGoNext {
    final now = DateTime.now();

    final currentMonth = DateTime(
      now.year,
      now.month,
    );

    final nextMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month + 1,
    );

    return !nextMonth.isAfter(currentMonth);
  }

  static String formatDuration(int seconds) {
    if (seconds <= 0) {
      return '0m';
    }

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    }

    if (hours > 0) {
      return '${hours}h';
    }

    return '${minutes}m';
  }
}