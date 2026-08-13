/// Normalizes [date] to local midnight for consistent calendar-day keys.
DateTime normalizeToLocalDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

/// Returns true when both dates fall on the same local calendar day.
bool isSameLocalDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
