import 'package:flutter/material.dart';
import 'package:study_planner/shared/domain/value_objects/day_time.dart';

enum OnboardingStatus { editing, submitting, success, failure }

/// Holds every field collected across the 7 onboarding steps.
class OnboardingState {
  const OnboardingState({
    this.pageIndex = 0,
    this.name = '',
    this.grade,
    this.selectedDailyGoalMinutes = 120,
    this.customDailyGoalSelected = false,
    this.customDailyGoalHours = 2,
    this.customDailyGoalMinutesPart = 0,
    this.selectedStudyMinutes = 25,
    this.customStudySelected = false,
    this.customStudyMinutes = 60,
    this.selectedBreakMinutes = 5,
    this.wakeUpTime = const DayTime(hour: 7, minute: 0),
    this.sleepTime = const DayTime(hour: 22, minute: 30),
    this.notificationEnabled = false,
    this.notificationTime = const TimeOfDay(hour: 19, minute: 0),
    this.status = OnboardingStatus.editing,
    this.errorMessage,
  });

  static const totalPages = 7;
  static const dailyGoalOptions = [60, 120, 180, 240];
  static const studySessionOptions = [25, 45, 60];
  static const breakOptions = [5, 10, 15];
  static const gradeOptions = [
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12',
    'University',
    'Other',
  ];

  final int pageIndex;
  final String name;
  final String? grade;
  final int selectedDailyGoalMinutes;
  final bool customDailyGoalSelected;
  final int customDailyGoalHours;
  final int customDailyGoalMinutesPart;
  final int selectedStudyMinutes;
  final bool customStudySelected;
  final int customStudyMinutes;
  final int selectedBreakMinutes;
  final DayTime wakeUpTime;
  final DayTime sleepTime;
  final bool notificationEnabled;
  final TimeOfDay notificationTime;
  final OnboardingStatus status;
  final String? errorMessage;

  int? get customDailyGoalTotalMinutes {
    final total = (customDailyGoalHours * 60) + customDailyGoalMinutesPart;
    return total > 0 ? total : null;
  }

  int get currentDailyGoalMinutes {
    if (customDailyGoalSelected) {
      return customDailyGoalTotalMinutes ?? selectedDailyGoalMinutes;
    }
    return selectedDailyGoalMinutes;
  }

  int get currentStudyMinutes {
    if (customStudySelected) {
      return customStudyMinutes > 0 ? customStudyMinutes : selectedStudyMinutes;
    }
    return selectedStudyMinutes;
  }

  bool get hasValidName => name.trim().isNotEmpty;

  bool get canContinue {
    if (status == OnboardingStatus.submitting) return false;
    return switch (pageIndex) {
      0 => true,
      1 => hasValidName,
      2 => grade != null,
      3 => !customDailyGoalSelected || customDailyGoalTotalMinutes != null,
      4 => !customStudySelected || customStudyMinutes > 0,
      5 => true,
      6 => true,
      _ => false,
    };
  }

  String get dailyGoalLabel => _formatMinutes(currentDailyGoalMinutes);

  String get studySessionLabel => '$currentStudyMinutes min';

  String get reminderLabel {
    if (!notificationEnabled) return 'Off';
    return _formatTimeOfDay(notificationTime);
  }

  OnboardingState copyWith({
    int? pageIndex,
    String? name,
    String? grade,
    int? selectedDailyGoalMinutes,
    bool? customDailyGoalSelected,
    int? customDailyGoalHours,
    int? customDailyGoalMinutesPart,
    int? selectedStudyMinutes,
    bool? customStudySelected,
    int? customStudyMinutes,
    int? selectedBreakMinutes,
    DayTime? wakeUpTime,
    DayTime? sleepTime,
    bool? notificationEnabled,
    TimeOfDay? notificationTime,
    OnboardingStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      selectedDailyGoalMinutes:
          selectedDailyGoalMinutes ?? this.selectedDailyGoalMinutes,
      customDailyGoalSelected:
          customDailyGoalSelected ?? this.customDailyGoalSelected,
      customDailyGoalHours: customDailyGoalHours ?? this.customDailyGoalHours,
      customDailyGoalMinutesPart:
          customDailyGoalMinutesPart ?? this.customDailyGoalMinutesPart,
      selectedStudyMinutes: selectedStudyMinutes ?? this.selectedStudyMinutes,
      customStudySelected: customStudySelected ?? this.customStudySelected,
      customStudyMinutes: customStudyMinutes ?? this.customStudyMinutes,
      selectedBreakMinutes: selectedBreakMinutes ?? this.selectedBreakMinutes,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      sleepTime: sleepTime ?? this.sleepTime,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  static String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remainder = minutes % 60;
    if (hours > 0 && remainder > 0) return '${hours}h ${remainder}m';
    if (hours > 0) return '${hours}h';
    return '${remainder}m';
  }

  static String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
