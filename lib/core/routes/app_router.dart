import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/core/di/injection.dart';
import 'package:study_planner/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:study_planner/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:study_planner/shared/domain/repositories/student_profile_repository.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const dashboard = '/dashboard';
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
        builder: (context, state) => const DashboardPage(),
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
