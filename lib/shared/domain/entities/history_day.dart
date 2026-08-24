class HistoryDay {
  const HistoryDay({
    required this.date,
    required this.completedSessions,
    required this.subjectCounts,
    required this.totalSeconds,
  });

  final DateTime date;
  final int completedSessions;
  final Map<String, int> subjectCounts;
  final int totalSeconds;
}