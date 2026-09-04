import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/l10n/app_localizations_ar.dart';
import 'package:study_planner/l10n/app_localizations_en.dart';
import 'package:study_planner/shared/domain/enums/app_language.dart';

/// Service-layer helper that exposes localized notification strings.
///
/// ## Design rationale
/// The generated [AppLocalizationsEn] and [AppLocalizationsAr] classes are
/// plain Dart objects — their constructors take only a locale string and
/// contain no [BuildContext] dependency. They can therefore be instantiated
/// safely from any isolate, including the background timer isolate.
///
/// [NotificationStrings] is the **single source of truth** for notification
/// text: it delegates directly to the already-generated localization classes
/// instead of duplicating any translations. There is no parallel string table.
///
/// ## Usage
/// ```dart
/// final strings = NotificationStrings.forLanguage(AppLanguage.ar);
/// await notificationService.showStudyComplete(
///   title: strings.studyCompleteTitle,
///   body:  strings.studyCompleteBody,
/// );
/// ```
class NotificationStrings {
  NotificationStrings._(this._l10n);

  factory NotificationStrings.forLanguage(AppLanguage language) {
    final AppLocalizations l10n = switch (language) {
      AppLanguage.ar => AppLocalizationsAr(),
      AppLanguage.en => AppLocalizationsEn(),
    };
    return NotificationStrings._(l10n);
  }

  final AppLocalizations _l10n;

  // ── Study session completed ───────────────────────────────────────────────

  String get studyCompleteTitle => _l10n.notifStudyCompleteTitle;
  String get studyCompleteBody  => _l10n.notifStudyCompleteBody;

  // ── Break finished ────────────────────────────────────────────────────────

  String get breakFinishedTitle => _l10n.notifBreakFinishedTitle;
  String get breakFinishedBody  => _l10n.notifBreakFinishedBody;

  // ── Break started ─────────────────────────────────────────────────────────

  String get breakStartedTitle => _l10n.notifBreakStartedTitle;
  String get breakStartedBody  => _l10n.notifBreakStartedBody;

  // ── Scheduled study session starting ─────────────────────────────────────

  String get studyStartingTitle => _l10n.notifStudyStartingTitle;

  /// [subjectName] is raw database data — never translated.
  String studyStartingBody(String subjectName) =>
      _l10n.notifStudyStartingBody(subjectName);

  // ── Subject completed ─────────────────────────────────────────────────────

  String get subjectCompleteTitle => _l10n.notifSubjectCompleteTitle;

  /// [subjectName] is raw database data — never translated.
  String subjectCompleteBody(String subjectName) =>
      _l10n.notifSubjectCompleteBody(subjectName);

  // ── Daily goal reached ────────────────────────────────────────────────────

  String get dailyGoalTitle => _l10n.notifDailyGoalTitle;
  String get dailyGoalBody  => _l10n.notifDailyGoalBody;

  // ── Foreground timer (background isolate) ────────────────────────────────

  String get foregroundFocusLabel => _l10n.notifForegroundFocusLabel;
  String get foregroundBreakLabel => _l10n.notifForegroundBreakLabel;

  /// [phase] is one of [foregroundFocusLabel] / [foregroundBreakLabel].
  /// [subjectName] is raw database data — never translated.
  String foregroundTitle(String phase, String subjectName) =>
      _l10n.notifForegroundTitle(phase, subjectName);

  /// [remaining] is a formatted time string such as '24:30'.
  String foregroundBody(String remaining) =>
      _l10n.notifForegroundBody(remaining);

  // ── Initial background-service notification ──────────────────────────────

  String get initialTitle   => _l10n.notifInitialTitle;
  String get initialContent => _l10n.notifInitialContent;
}
