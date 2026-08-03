import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const double _baseFontSize = 16;

  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        studyFlowColors: StudyFlowColors.light,
        scaffoldBackground: AppColors.lightBackground,
        cardColor: AppColors.lightCard,
      );

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        colorScheme: _darkColorScheme,
        studyFlowColors: StudyFlowColors.dark,
        scaffoldBackground: AppColors.darkBackground,
        cardColor: AppColors.darkCard,
      );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightPrimaryForeground,
    secondary: AppColors.lightSecondary,
    onSecondary: AppColors.lightSecondaryForeground,
    tertiary: AppColors.lightAccent,
    onTertiary: AppColors.lightAccentForeground,
    error: AppColors.lightDestructive,
    onError: AppColors.lightDestructiveForeground,
    surface: AppColors.lightBackground,
    onSurface: AppColors.lightForeground,
    surfaceContainerHighest: AppColors.lightMuted,
    onSurfaceVariant: AppColors.lightMutedForeground,
    outline: AppColors.lightBorder,
    outlineVariant: AppColors.lightInput,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkPrimaryForeground,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkSecondaryForeground,
    tertiary: AppColors.darkAccent,
    onTertiary: AppColors.darkAccentForeground,
    error: AppColors.darkDestructive,
    onError: AppColors.darkDestructiveForeground,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkForeground,
    surfaceContainerHighest: AppColors.darkMuted,
    onSurfaceVariant: AppColors.darkMutedForeground,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkInput,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required StudyFlowColors studyFlowColors,
    required Color scaffoldBackground,
    required Color cardColor,
  }) {
    final textTheme = _textTheme(colorScheme.onSurface);
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      extensions: [studyFlowColors],
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      // cardTheme: CardTheme(
      //   color: cardColor,
      //   elevation: 0,
      //   shadowColor: Colors.black.withValues(alpha: 0.08),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppColors.radiusLg),
      //   ),
      //   margin: EdgeInsets.zero,
      // ),
      dividerTheme: DividerThemeData(
        color: studyFlowColors.border,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: studyFlowColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: studyFlowColors.mutedForeground,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          borderSide: BorderSide(color: studyFlowColors.input, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          borderSide: BorderSide(color: studyFlowColors.input, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          borderSide: BorderSide(color: studyFlowColors.ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }
          return studyFlowColors.switchBackground;
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.5),
          disabledForegroundColor: colorScheme.onPrimary.withValues(alpha: 0.7),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusLg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusLg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: studyFlowColors.border, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusLg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.radiusLg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: studyFlowColors.mutedForeground,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: studyFlowColors.primaryLight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: selected
                ? colorScheme.primary
                : studyFlowColors.mutedForeground,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? colorScheme.primary
                : studyFlowColors.mutedForeground,
            size: 24,
          );
        }),
        elevation: 0,
        height: 72,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: studyFlowColors.primaryLight,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: studyFlowColors.muted,
        circularTrackColor: studyFlowColors.muted,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.darkPopover : AppColors.lightPopover,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark
              ? AppColors.darkPopoverForeground
              : AppColors.lightPopoverForeground,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
        ),
      ),
      // dialogTheme: DialogTheme(
      //   backgroundColor: isDark ? AppColors.darkPopover : AppColors.lightPopover,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppColors.radiusLg),
      //   ),
      //   titleTextStyle: textTheme.titleLarge?.copyWith(
      //     fontWeight: FontWeight.w600,
      //     color: isDark
      //         ? AppColors.darkPopoverForeground
      //         : AppColors.lightPopoverForeground,
      //   ),
      // ),
    );
  }

  static TextTheme _textTheme(Color onSurface) {
    const height = 1.5;

    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: height,
        color: onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: height,
        color: onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: height,
        color: onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: _baseFontSize,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: _baseFontSize,
        fontWeight: FontWeight.w400,
        height: height,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: height,
        color: onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: height,
        color: onSurface,
      ),
      labelLarge: TextStyle(
        fontSize: _baseFontSize,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: height,
        color: onSurface,
      ),
    );
  }
}
