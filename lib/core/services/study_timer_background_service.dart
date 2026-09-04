import 'dart:async';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:isar/isar.dart';
import 'package:study_planner/core/services/notification_strings.dart';
import 'package:study_planner/core/services/study_timer_service.dart';
import 'package:study_planner/core/services/timer_notification_service.dart';
import 'package:study_planner/shared/data/database/isar.dart';
import 'package:study_planner/shared/data/repositories/active_timer_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/app_settings_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/daily_plan_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/student_profile_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/study_session_repository_impl.dart';
import 'package:study_planner/shared/data/repositories/subject_repository_impl.dart';
import 'package:study_planner/shared/domain/entities/active_timer_state.dart';
class StudyTimerBackgroundService {
  StudyTimerBackgroundService({
    FlutterBackgroundService? service,
    TimerNotificationService? notificationService,
  }) : _service = service ?? FlutterBackgroundService(),
       _notificationService =
           notificationService ?? TimerNotificationService();

  final FlutterBackgroundService _service;
  final TimerNotificationService _notificationService;
  bool _configured = false;

  Future<void> configure() async {
    if (_configured) return;
    await _notificationService.initialize();
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: false,
        autoStartOnBoot: true,
        isForegroundMode: true,
        notificationChannelId: TimerNotificationService.foregroundChannelId,
        // Initial title/body are shown before the first ticker fires (~1 s).
        // They use English as a safe default; the ticker immediately replaces
        // them with the persisted-language version on its first run.
        initialNotificationTitle: 'Study timer running',
        initialNotificationContent: 'Keeping your session on track.',
        foregroundServiceNotificationId:
            TimerNotificationService.foregroundNotificationId,
        foregroundServiceTypes: const [AndroidForegroundType.specialUse],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );
    _configured = true;
  }

  Future<void> start() async {
    await configure();
    if (!await _service.isRunning()) {
      await _service.startService();
    }
  }

  Future<void> stop() async {
    if (await _service.isRunning()) {
      _service.invoke('stopService');
    }
    await _notificationService.cancelForeground();
  }
}

@pragma('vm:entry-point')
Future<bool> _onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void _onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final notificationService = TimerNotificationService();
  await notificationService.initialize();

  Timer? ticker;
  service.on('stopService').listen((event) async {
    ticker?.cancel();
    await notificationService.cancelForeground();
    service.stopSelf();
  });

  ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
    try {
      final isar = await _openIsarForBackground();
      final activeTimerRepository = ActiveTimerRepositoryImpl(isar);
      final subjectRepository = SubjectRepositoryImpl(isar);
      final timer = await activeTimerRepository.getActiveTimer();

      if (timer == null || timer.phase == ActiveTimerPhase.paused) {
        await notificationService.cancelForeground();
        service.stopSelf();
        ticker?.cancel();
        return;
      }

      final subject = await subjectRepository.getById(timer.subjectId);
      if (subject == null) return;

      final settingsRepo = AppSettingsRepositoryImpl(isar);
      final settings = await settingsRepo.getSettings();
      final strings = NotificationStrings.forLanguage(settings.language);

      final coordinator = StudyTimerService(
        studentProfileRepository: StudentProfileRepositoryImpl(isar),
        activeTimerRepository: activeTimerRepository,
        sessionRepository: StudySessionRepositoryImpl(isar),
        dailyPlanRepository: DailyPlanRepositoryImpl(isar),
        settingsRepository: settingsRepo,
        subjectRepository: subjectRepository,
        notificationService: notificationService,
      );
      final snapshot = await coordinator.reconcile(subject: subject) ??
          await coordinator.restoreForSubject(subject);
      final latest = snapshot?.timer;

      if (latest == null) {
        await notificationService.cancelForeground();
        service.stopSelf();
        ticker?.cancel();
        return;
      }

      final phaseLabel = latest.phase == ActiveTimerPhase.breakTime
          ? strings.foregroundBreakLabel
          : strings.foregroundFocusLabel;

      await notificationService.showForegroundTimer(
        title: strings.foregroundTitle(phaseLabel, subject.name),
        body:  strings.foregroundBody(
          _formatRemaining(snapshot!.remainingSeconds),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Background timer tick failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  });
}

Future<Isar> _openIsarForBackground() async {
  try {
    return IsarDatabase.instance;
  } catch (_) {
    return IsarDatabase.initialize();
  }
}

String _formatRemaining(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:'
      '${remainingSeconds.toString().padLeft(2, '0')}';
}
