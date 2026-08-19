import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimerNotificationService {
  TimerNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const int foregroundNotificationId = 7000;
  static const int studyCompletionId = 7001;
  static const int breakCompletionId = 7002;
  static const int breakStartedId = 7003;
  static const int scheduledStudyId = 7004;

  static const String timerChannelId = 'study_timer';
  static const String timerChannelName = 'Study timer';
  static const String foregroundChannelId = 'study_timer_foreground';
  static const String foregroundChannelName = 'Active study timer';

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    await _setLocalTimezone();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
      ),
    );

    await _createAndroidChannels();
    await requestPermissions();
    _initialized = true;
  }

  Future<void> requestPermissions() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await android?.requestNotificationsPermission();
      await android?.requestExactAlarmsPermission();

      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      await ios?.requestPermissions(alert: true, badge: true, sound: true);

      final macos = _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >();
      await macos?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (error, stackTrace) {
      debugPrint('Notification permission request failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> scheduleStudyCompleted({
    required DateTime endsAt,
    required Subject subject,
  }) {
    return _schedule(
      id: studyCompletionId,
      title: 'Study session complete',
      body: 'Great job! Your study session is finished. Time for a break.',
      scheduledAt: endsAt,
      payload: 'session:${subject.id}',
    );
  }

  Future<void> scheduleBreakCompleted({
    required DateTime endsAt,
    required Subject subject,
  }) {
    return _schedule(
      id: breakCompletionId,
      title: 'Break finished',
      body: 'Break time is over. Ready to start studying again?',
      scheduledAt: endsAt,
      payload: 'session:${subject.id}',
    );
  }

  Future<void> schedulePlannedStudy({
    required DateTime startsAt,
    required Subject subject,
  }) {
    return _schedule(
      id: scheduledStudyId + subject.id,
      title: 'Study session starting',
      body: "It's time to study ${subject.name}.",
      scheduledAt: startsAt,
      payload: 'session:${subject.id}',
    );
  }

  Future<void> showStudyComplete() {
    return showNow(
      id: studyCompletionId,
      title: 'Study session complete',
      body: 'Great job! Your study session is finished. Time for a break.',
    );
  }

  Future<void> showBreakStarted() {
    return showNow(
      id: breakStartedId,
      title: 'Break time',
      body: 'Your study session is complete. Take a short break.',
    );
  }

  Future<void> showBreakComplete() {
    return showNow(
      id: breakCompletionId,
      title: 'Break finished',
      body: 'Break time is over. Ready to start studying again?',
    );
  }

  Future<void> showForegroundTimer({
    required String title,
    required String body,
  }) {
    return _show(
      id: foregroundNotificationId,
      title: title,
      body: body,
      channelId: foregroundChannelId,
      channelName: foregroundChannelName,
      ongoing: true,
      importance: Importance.low,
      priority: Priority.low,
    );
  }

  Future<void> showNow({
    required int id,
    required String title,
    required String body,
  }) {
    return _show(
      id: id,
      title: title,
      body: body,
      channelId: timerChannelId,
      channelName: timerChannelName,
      ongoing: false,
      importance: Importance.high,
      priority: Priority.high,
    );
  }

  Future<void> cancelTimerSchedules() async {
    await Future.wait([
      _plugin.cancel(id: studyCompletionId),
      _plugin.cancel(id: breakCompletionId),
      _plugin.cancel(id: breakStartedId),
      _plugin.cancel(id: foregroundNotificationId),
    ]);
  }

  Future<void> cancelForeground() => _plugin.cancel(id: foregroundNotificationId);

  Future<void> _schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    required String payload,
  }) async {
    await initialize();
    await _plugin.cancel(id: id);
    if (!scheduledAt.isAfter(DateTime.now())) {
      await showNow(id: id, title: title, body: body);
      return;
    }

    final scheduledDate = tz.TZDateTime.from(scheduledAt, tz.local);
    final details = _notificationDetails(
      channelId: timerChannelId,
      channelName: timerChannelName,
      ongoing: false,
      importance: Importance.high,
      priority: Priority.high,
    );

    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (error, stackTrace) {
      debugPrint('Exact notification scheduling failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  Future<void> _show({
    required int id,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required bool ongoing,
    required Importance importance,
    required Priority priority,
  }) async {
    await initialize();
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _notificationDetails(
        channelId: channelId,
        channelName: channelName,
        ongoing: ongoing,
        importance: importance,
        priority: priority,
      ),
      payload: 'session',
    );
  }

  NotificationDetails _notificationDetails({
    required String channelId,
    required String channelName,
    required bool ongoing,
    required Importance importance,
    required Priority priority,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Study timer reminders and status updates.',
        ongoing: ongoing,
        autoCancel: !ongoing,
        importance: importance,
        priority: priority,
        category: AndroidNotificationCategory.alarm,
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> _createAndroidChannels() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return;

    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        timerChannelId,
        timerChannelName,
        description: 'Study timer completion reminders.',
        importance: Importance.high,
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        foregroundChannelId,
        foregroundChannelName,
        description: 'Persistent notification while a study timer is active.',
        importance: Importance.low,
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
