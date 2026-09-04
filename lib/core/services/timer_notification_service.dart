import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Generic notification service for the study timer.
///
/// This class has no knowledge of localization, languages, or user preferences.
/// All user-facing strings (title, body) are passed in by the caller.
/// The [NotificationStrings] helper in the service layer is responsible for
/// supplying the correct localized text.
class TimerNotificationService {
  TimerNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  // ── Notification IDs (never change — referenced by platform) ─────────────

  static const int foregroundNotificationId = 7000;
  static const int studyCompletionId        = 7001;
  static const int breakCompletionId        = 7002;
  static const int breakStartedId           = 7003;
  static const int scheduledStudyId         = 7004;
  static const int subjectCompletedId       = 7005;
  static const int dailyGoalReachedId       = 7006;

  // ── Channel IDs (stable — Android channels are persistent) ───────────────

  static const String timerChannelId          = 'study_timer';
  static const String timerChannelName        = 'Study timer';
  static const String foregroundChannelId     = 'study_timer_foreground';
  static const String foregroundChannelName   = 'Active study timer';

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  // ── Initialization ────────────────────────────────────────────────────────

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    await _setLocalTimezone();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings  = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS:     darwinSettings,
        macOS:   darwinSettings,
      ),
    );

    await _createAndroidChannels();
    await requestPermissions();
    _initialized = true;
  }

  Future<void> requestPermissions() async {
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
      await android?.requestExactAlarmsPermission();

      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      await ios?.requestPermissions(alert: true, badge: true, sound: true);

      final macos = _plugin.resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>();
      await macos?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (error, stackTrace) {
      debugPrint('Notification permission request failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  // ── Scheduled notifications ───────────────────────────────────────────────
  // Callers resolve the localized title/body at scheduling time so the correct
  // language is embedded in the scheduled notification payload.

  Future<void> scheduleStudyCompleted({
    required DateTime endsAt,
    required Subject subject,
    required String title,
    required String body,
  }) {
    return _schedule(
      id:          studyCompletionId,
      title:       title,
      body:        body,
      scheduledAt: endsAt,
      payload:     'session:${subject.id}',
    );
  }

  Future<void> scheduleBreakCompleted({
    required DateTime endsAt,
    required Subject subject,
    required String title,
    required String body,
  }) {
    return _schedule(
      id:          breakCompletionId,
      title:       title,
      body:        body,
      scheduledAt: endsAt,
      payload:     'session:${subject.id}',
    );
  }

  Future<void> schedulePlannedStudy({
    required DateTime startsAt,
    required Subject subject,
    required String title,
    required String body,
  }) {
    return _schedule(
      id:          scheduledStudyId + subject.id,
      title:       title,
      body:        body,
      scheduledAt: startsAt,
      payload:     'session:${subject.id}',
    );
  }

  // ── Immediate notifications ───────────────────────────────────────────────

  Future<void> showStudyComplete({
    required String title,
    required String body,
  }) {
    return showNow(id: studyCompletionId, title: title, body: body);
  }

  Future<void> showBreakStarted({
    required String title,
    required String body,
  }) {
    return showNow(id: breakStartedId, title: title, body: body);
  }

  Future<void> showBreakComplete({
    required String title,
    required String body,
  }) {
    return showNow(id: breakCompletionId, title: title, body: body);
  }

  Future<void> showSubjectCompleted({
    required String title,
    required String body,
  }) {
    return showNow(id: subjectCompletedId, title: title, body: body);
  }

  Future<void> showDailyGoalReached({
    required String title,
    required String body,
  }) {
    return showNow(id: dailyGoalReachedId, title: title, body: body);
  }

  Future<void> showForegroundTimer({
    required String title,
    required String body,
  }) {
    return _show(
      id:          foregroundNotificationId,
      title:       title,
      body:        body,
      channelId:   foregroundChannelId,
      channelName: foregroundChannelName,
      ongoing:     true,
      importance:  Importance.low,
      priority:    Priority.low,
    );
  }

  // ── Low-level show ────────────────────────────────────────────────────────

  Future<void> showNow({
    required int    id,
    required String title,
    required String body,
  }) {
    return _show(
      id:          id,
      title:       title,
      body:        body,
      channelId:   timerChannelId,
      channelName: timerChannelName,
      ongoing:     false,
      importance:  Importance.high,
      priority:    Priority.high,
    );
  }

  // ── Cancellation ─────────────────────────────────────────────────────────

  Future<void> cancelTimerSchedules() async {
    await Future.wait([
      _plugin.cancel(id: studyCompletionId),
      _plugin.cancel(id: breakCompletionId),
      _plugin.cancel(id: breakStartedId),
      _plugin.cancel(id: foregroundNotificationId),
    ]);
  }

  Future<void> cancelForeground() =>
      _plugin.cancel(id: foregroundNotificationId);

  // ── Private implementation ────────────────────────────────────────────────

  Future<void> _schedule({
    required int      id,
    required String   title,
    required String   body,
    required DateTime scheduledAt,
    required String   payload,
  }) async {
    await initialize();
    await _plugin.cancel(id: id);

    if (!scheduledAt.isAfter(DateTime.now())) {
      await showNow(id: id, title: title, body: body);
      return;
    }

    final scheduledDate = tz.TZDateTime.from(scheduledAt, tz.local);
    final details = _notificationDetails(
      channelId:   timerChannelId,
      channelName: timerChannelName,
      ongoing:     false,
      importance:  Importance.high,
      priority:    Priority.high,
    );

    try {
      await _plugin.zonedSchedule(
        id:                  id,
        title:               title,
        body:                body,
        scheduledDate:       scheduledDate,
        notificationDetails: details,
        payload:             payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (error, stackTrace) {
      debugPrint('Exact notification scheduling failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      await _plugin.zonedSchedule(
        id:                  id,
        title:               title,
        body:                body,
        scheduledDate:       scheduledDate,
        notificationDetails: details,
        payload:             payload,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  Future<void> _show({
    required int        id,
    required String     title,
    required String     body,
    required String     channelId,
    required String     channelName,
    required bool       ongoing,
    required Importance importance,
    required Priority   priority,
  }) async {
    await initialize();
    await _plugin.show(
      id:                  id,
      title:               title,
      body:                body,
      notificationDetails: _notificationDetails(
        channelId:   channelId,
        channelName: channelName,
        ongoing:     ongoing,
        importance:  importance,
        priority:    priority,
      ),
      payload: 'session',
    );
  }

  NotificationDetails _notificationDetails({
    required String     channelId,
    required String     channelName,
    required bool       ongoing,
    required Importance importance,
    required Priority   priority,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        // Channel description kept in English — Android channel metadata is
        // persistent and cannot be updated after first creation.
        channelDescription: 'Study timer reminders and status updates.',
        ongoing:   ongoing,
        autoCancel: !ongoing,
        importance: importance,
        priority:   priority,
        category:   AndroidNotificationCategory.alarm,
      ),
      iOS:   const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> _createAndroidChannels() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return;

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        timerChannelId,
        timerChannelName,
        description: 'Study timer completion reminders.',
        importance:  Importance.high,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        foregroundChannelId,
        foregroundChannelName,
        description: 'Persistent notification while a study timer is active.',
        importance:  Importance.low,
      ),
    );
  }

  Future<void> _setLocalTimezone() async {
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone.identifier));
    } catch (error, stackTrace) {
      debugPrint('Timezone initialization fell back to UTC: $error');
      debugPrintStack(stackTrace: stackTrace);
      tz.setLocalLocation(tz.UTC);
    }
  }
}
