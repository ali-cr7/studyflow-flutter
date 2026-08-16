import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/service%20locator/injection.dart';
import 'package:study_planner/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:study_planner/features/main_shell_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:study_planner/features/planner/presentation/pages/daily_plan_page.dart';
import 'package:study_planner/features/planner/presentation/pages/subjects_page.dart';
import 'package:study_planner/features/session/presentation/pages/session_page.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const dashboard = '/dashboard';
  static const subjects = '/subjects';
  static const dailyPlan = '/daily-plan';
  static const session = '/session';
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
          if (args == null) {
            return const DailyPlanPage();
          }

          return SessionPage(
            subject: args.subject,
            plannedMinutes: args.plannedMinutes,
          );
        },
      ),
    ],
  );

  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final hasProfile = await getIt<StudentProfileRepository>().hasProfile();
    final location = state.matchedLocation;

    if (!hasProfile && location != AppRoutes.onboarding) {
      return AppRoutes.onboarding;
    }

    if (hasProfile && location == AppRoutes.onboarding) {
      return AppRoutes.dashboard;
    }

    return null;
  }
}
