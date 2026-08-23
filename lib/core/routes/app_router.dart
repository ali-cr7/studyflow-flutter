import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/achievements/presentation/achievement_page.dart';
import 'package:study_planner/features/activation/presentation/activation_page.dart';
import 'package:study_planner/features/ask_teacher/presentation/screens/ask_teacher_screen.dart';
import 'package:study_planner/features/main_shell_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_page.dart';
import 'package:study_planner/features/session/presentation/pages/session_page.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/license_repository.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const activation = '/activation';
  static const dashboard = '/dashboard';
  static const subjects = '/subjects';
  static const dailyPlan = '/daily-plan';
  static const session = '/session';
  static const askTeacher = '/ask-teacher';
  static const achievements = '/achievements';
}

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.askTeacher,
        builder: (context, state) {
          final args = state.extra as AskTeacherRouteArgs?;
          if (args == null) return const DailyPlanPage();
          return AskTeacherScreen(
            studentName: args.studentName,
            subjects: args.subjects,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.activation,
        builder: (context, state) => const ActivationPage(),
      ),
      GoRoute(
        path: AppRoutes.achievements,
        builder: (context, state) {
          return const AchievementsPage();
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const MainShellPage(),
      ),
      GoRoute(
        path: AppRoutes.subjects,
        builder: (context, state) => const MainShellPage(),
      ),
      GoRoute(
        path: AppRoutes.dailyPlan,
        builder: (context, state) => const MainShellPage(),
      ),
      GoRoute(
        path: AppRoutes.session,
        builder: (context, state) {
          final args = state.extra as SessionRouteArgs?;
          if (args == null) return const DailyPlanPage();
          return SessionPage(
            subject: args.subject,
            plannedMinutes: args.plannedMinutes,
          );
        },
      ),
    ],
  );

  // ── Navigation guard ─────────────────────────────────────────────────────
  //
  // Priority order (each check only runs if the previous passed):
  //
  //   1. No profile   → /onboarding        (set up name/grade first)
  //   2. No license   → /activation        (must activate before using app)
  //   3. Otherwise    → let the request through (or redirect away from
  //                     onboarding/activation if already done)
  //
  // isActivated() uses a synchronous Isar read internally, so this async
  // function is fast on every navigation after the first launch.

  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final location = state.matchedLocation;

    // ── Step 1: profile check ─────────────────────────────────────────────
    final hasProfile = await getIt<StudentProfileRepository>().hasProfile();

    if (!hasProfile) {
      // No profile yet → must onboard first.
      return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
    }

    // Has profile and is at onboarding → push forward.
    if (location == AppRoutes.onboarding) {
      // Will be resolved by step 2 below.
    }

    // ── Step 2: license check ─────────────────────────────────────────────
    final isActivated = await getIt<LicenseRepository>().isActivated();

    if (!isActivated) {
      // Profile exists but not yet activated.
      return location == AppRoutes.activation ? null : AppRoutes.activation;
    }

    // Activated — redirect away from gate screens.
    if (location == AppRoutes.onboarding || location == AppRoutes.activation) {
      return AppRoutes.dashboard;
    }

    // All checks passed — no redirect needed.
    return null;
  }
}

class AskTeacherRouteArgs {
  const AskTeacherRouteArgs({
    required this.studentName,
    required this.subjects,
  });

  final String studentName;
  final List<Subject> subjects;
}
