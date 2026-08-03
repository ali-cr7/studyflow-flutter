import 'package:flutter/material.dart';

/// StudyFlow color tokens mapped from `src/styles/theme.css`.
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Layout tokens
  // ---------------------------------------------------------------------------

  static const double radiusSm = 12; // --radius-sm (16 - 4)
  static const double radiusMd = 14; // --radius-md (16 - 2)
  static const double radiusLg = 16; // --radius
  static const double radiusXl = 20; // --radius-xl (16 + 4)

  // ---------------------------------------------------------------------------
  // Light theme
  // ---------------------------------------------------------------------------

  static const Color lightBackground = Color(0xFFF8F9FB);
  static const Color lightForeground = Color(0xFF1A1C1E);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF1A1C1E);
  static const Color lightPopover = Color(0xFFFFFFFF);
  static const Color lightPopoverForeground = Color(0xFF1A1C1E);

  static const Color lightPrimary = Color(0xFF4C6FFF);
  static const Color lightPrimaryForeground = Color(0xFFFFFFFF);
  static const Color lightPrimaryLight = Color(0xFFE8EDFF);
  static const Color lightPrimaryDark = Color(0xFF3D5AE6);

  static const Color lightSuccess = Color(0xFF34C759);
  static const Color lightSuccessForeground = Color(0xFFFFFFFF);
  static const Color lightSuccessLight = Color(0xFFE7F9EC);
  static const Color lightSuccessDark = Color(0xFF2BA84A);

  static const Color lightAccent = Color(0xFFFF9F43);
  static const Color lightAccentForeground = Color(0xFF1A1C1E);
  static const Color lightAccentLight = Color(0xFFFFF3E6);
  static const Color lightAccentDark = Color(0xFFE68A2E);

  static const Color lightSecondary = Color(0xFFF1F3F5);
  static const Color lightSecondaryForeground = Color(0xFF1A1C1E);
  static const Color lightMuted = Color(0xFFE9ECEF);
  static const Color lightMutedForeground = Color(0xFF6C757D);

  static const Color lightDestructive = Color(0xFFFF3B30);
  static const Color lightDestructiveForeground = Color(0xFFFFFFFF);
  static const Color lightWarning = Color(0xFFFFCC00);
  static const Color lightWarningForeground = Color(0xFF1A1C1E);
  static const Color lightWarningLight = Color(0xFFFFF9E6);

  static const Color lightBorder = Color(0xFFE1E4E8);
  static const Color lightInput = Color(0xFFE1E4E8);
  static const Color lightInputBackground = Color(0xFFF8F9FB);
  static const Color lightSwitchBackground = Color(0xFFDEE2E6);
  static const Color lightRing = Color(0xFF4C6FFF);

  static const Color lightChart1 = Color(0xFF4C6FFF);
  static const Color lightChart2 = Color(0xFF34C759);
  static const Color lightChart3 = Color(0xFFFF9F43);
  static const Color lightChart4 = Color(0xFFAF52DE);
  static const Color lightChart5 = Color(0xFFFF3B30);

  // ---------------------------------------------------------------------------
  // Dark theme
  // ---------------------------------------------------------------------------

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkForeground = Color(0xFFE8EAED);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkCardForeground = Color(0xFFE8EAED);
  static const Color darkPopover = Color(0xFF2A2A2A);
  static const Color darkPopoverForeground = Color(0xFFE8EAED);

  static const Color darkPrimary = Color(0xFF6B8AFF);
  static const Color darkPrimaryForeground = Color(0xFFFFFFFF);
  static const Color darkPrimaryLight = Color(0xFF1A2744);
  static const Color darkPrimaryDark = Color(0xFF5374F0);

  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkSuccessForeground = Color(0xFFFFFFFF);
  static const Color darkSuccessLight = Color(0xFF1A3324);
  static const Color darkSuccessDark = Color(0xFF3BC76A);

  static const Color darkAccent = Color(0xFFFFB366);
  static const Color darkAccentForeground = Color(0xFF1A1C1E);
  static const Color darkAccentLight = Color(0xFF3D2A1A);
  static const Color darkAccentDark = Color(0xFFF0A050);

  static const Color darkSecondary = Color(0xFF2A2A2A);
  static const Color darkSecondaryForeground = Color(0xFFE8EAED);
  static const Color darkMuted = Color(0xFF3A3A3A);
  static const Color darkMutedForeground = Color(0xFF9CA3AF);

  static const Color darkDestructive = Color(0xFFFF453A);
  static const Color darkDestructiveForeground = Color(0xFFFFFFFF);
  static const Color darkWarning = Color(0xFFFFD60A);
  static const Color darkWarningForeground = Color(0xFF1A1C1E);
  static const Color darkWarningLight = Color(0xFF3D3520);

  static const Color darkBorder = Color(0xFF3A3A3A);
  static const Color darkInput = Color(0xFF3A3A3A);
  static const Color darkInputBackground = Color(0xFF1E1E1E);
  static const Color darkSwitchBackground = Color(0xFF4A4A4A);
  static const Color darkRing = Color(0xFF6B8AFF);

  static const Color darkChart1 = Color(0xFF6B8AFF);
  static const Color darkChart2 = Color(0xFF4ADE80);
  static const Color darkChart3 = Color(0xFFFFB366);
  static const Color darkChart4 = Color(0xFFC77DFF);
  static const Color darkChart5 = Color(0xFFFF6B6B);
}

/// Extra StudyFlow tokens that don't exist on [ColorScheme].
///
/// Access anywhere with:
/// `Theme.of(context).extension<StudyFlowColors>()!`
@immutable
class StudyFlowColors extends ThemeExtension<StudyFlowColors> {
  const StudyFlowColors({
    required this.cardForeground,
    required this.primaryLight,
    required this.primaryDark,
    required this.success,
    required this.successForeground,
    required this.successLight,
    required this.successDark,
    required this.accent,
    required this.accentForeground,
    required this.accentLight,
    required this.accentDark,
    required this.muted,
    required this.mutedForeground,
    required this.destructiveForeground,
    required this.warning,
    required this.warningForeground,
    required this.warningLight,
    required this.border,
    required this.input,
    required this.inputBackground,
    required this.switchBackground,
    required this.ring,
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
  });

  final Color cardForeground;
  final Color primaryLight;
  final Color primaryDark;
  final Color success;
  final Color successForeground;
  final Color successLight;
  final Color successDark;
  final Color accent;
  final Color accentForeground;
  final Color accentLight;
  final Color accentDark;
  final Color muted;
  final Color mutedForeground;
  final Color destructiveForeground;
  final Color warning;
  final Color warningForeground;
  final Color warningLight;
  final Color border;
  final Color input;
  final Color inputBackground;
  final Color switchBackground;
  final Color ring;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;

  static const StudyFlowColors light = StudyFlowColors(
    cardForeground: AppColors.lightCardForeground,
    primaryLight: AppColors.lightPrimaryLight,
    primaryDark: AppColors.lightPrimaryDark,
    success: AppColors.lightSuccess,
    successForeground: AppColors.lightSuccessForeground,
    successLight: AppColors.lightSuccessLight,
    successDark: AppColors.lightSuccessDark,
    accent: AppColors.lightAccent,
    accentForeground: AppColors.lightAccentForeground,
    accentLight: AppColors.lightAccentLight,
    accentDark: AppColors.lightAccentDark,
    muted: AppColors.lightMuted,
    mutedForeground: AppColors.lightMutedForeground,
    destructiveForeground: AppColors.lightDestructiveForeground,
    warning: AppColors.lightWarning,
    warningForeground: AppColors.lightWarningForeground,
    warningLight: AppColors.lightWarningLight,
    border: AppColors.lightBorder,
    input: AppColors.lightInput,
    inputBackground: AppColors.lightInputBackground,
    switchBackground: AppColors.lightSwitchBackground,
    ring: AppColors.lightRing,
    chart1: AppColors.lightChart1,
    chart2: AppColors.lightChart2,
    chart3: AppColors.lightChart3,
    chart4: AppColors.lightChart4,
    chart5: AppColors.lightChart5,
  );

  static const StudyFlowColors dark = StudyFlowColors(
    cardForeground: AppColors.darkCardForeground,
    primaryLight: AppColors.darkPrimaryLight,
    primaryDark: AppColors.darkPrimaryDark,
    success: AppColors.darkSuccess,
    successForeground: AppColors.darkSuccessForeground,
    successLight: AppColors.darkSuccessLight,
    successDark: AppColors.darkSuccessDark,
    accent: AppColors.darkAccent,
    accentForeground: AppColors.darkAccentForeground,
    accentLight: AppColors.darkAccentLight,
    accentDark: AppColors.darkAccentDark,
    muted: AppColors.darkMuted,
    mutedForeground: AppColors.darkMutedForeground,
    destructiveForeground: AppColors.darkDestructiveForeground,
    warning: AppColors.darkWarning,
    warningForeground: AppColors.darkWarningForeground,
    warningLight: AppColors.darkWarningLight,
    border: AppColors.darkBorder,
    input: AppColors.darkInput,
    inputBackground: AppColors.darkInputBackground,
    switchBackground: AppColors.darkSwitchBackground,
    ring: AppColors.darkRing,
    chart1: AppColors.darkChart1,
    chart2: AppColors.darkChart2,
    chart3: AppColors.darkChart3,
    chart4: AppColors.darkChart4,
    chart5: AppColors.darkChart5,
  );

  @override
  StudyFlowColors copyWith({
    Color? cardForeground,
    Color? primaryLight,
    Color? primaryDark,
    Color? success,
    Color? successForeground,
    Color? successLight,
    Color? successDark,
    Color? accent,
    Color? accentForeground,
    Color? accentLight,
    Color? accentDark,
    Color? muted,
    Color? mutedForeground,
    Color? destructiveForeground,
    Color? warning,
    Color? warningForeground,
    Color? warningLight,
    Color? border,
    Color? input,
    Color? inputBackground,
    Color? switchBackground,
    Color? ring,
    Color? chart1,
    Color? chart2,
    Color? chart3,
    Color? chart4,
    Color? chart5,
  }) {
    return StudyFlowColors(
      cardForeground: cardForeground ?? this.cardForeground,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      success: success ?? this.success,
      successForeground: successForeground ?? this.successForeground,
      successLight: successLight ?? this.successLight,
      successDark: successDark ?? this.successDark,
      accent: accent ?? this.accent,
      accentForeground: accentForeground ?? this.accentForeground,
      accentLight: accentLight ?? this.accentLight,
      accentDark: accentDark ?? this.accentDark,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      warning: warning ?? this.warning,
      warningForeground: warningForeground ?? this.warningForeground,
      warningLight: warningLight ?? this.warningLight,
      border: border ?? this.border,
      input: input ?? this.input,
      inputBackground: inputBackground ?? this.inputBackground,
      switchBackground: switchBackground ?? this.switchBackground,
      ring: ring ?? this.ring,
      chart1: chart1 ?? this.chart1,
      chart2: chart2 ?? this.chart2,
      chart3: chart3 ?? this.chart3,
      chart4: chart4 ?? this.chart4,
      chart5: chart5 ?? this.chart5,
    );
  }

  @override
  StudyFlowColors lerp(covariant ThemeExtension<StudyFlowColors>? other, double t) {
    if (other is! StudyFlowColors) return this;

    return StudyFlowColors(
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      success: Color.lerp(success, other.success, t)!,
      successForeground: Color.lerp(successForeground, other.successForeground, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentForeground: Color.lerp(accentForeground, other.accentForeground, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      destructiveForeground:
          Color.lerp(destructiveForeground, other.destructiveForeground, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningForeground: Color.lerp(warningForeground, other.warningForeground, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      border: Color.lerp(border, other.border, t)!,
      input: Color.lerp(input, other.input, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      switchBackground: Color.lerp(switchBackground, other.switchBackground, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      chart1: Color.lerp(chart1, other.chart1, t)!,
      chart2: Color.lerp(chart2, other.chart2, t)!,
      chart3: Color.lerp(chart3, other.chart3, t)!,
      chart4: Color.lerp(chart4, other.chart4, t)!,
      chart5: Color.lerp(chart5, other.chart5, t)!,
    );
  }
}

/// Convenience getter for widgets.
extension StudyFlowColorsContext on BuildContext {
  StudyFlowColors get sfColors =>
      Theme.of(this).extension<StudyFlowColors>() ?? StudyFlowColors.light;
}
