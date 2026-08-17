import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/features/statistics/presentation/pages/statistics_page.dart';

void main() {
  testWidgets(
    'Statistics overview shows progress summary and period selector',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: StatisticsPage()));

      expect(find.text('Your Progress'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Month'), findsOneWidget);
      expect(find.text('Study Time'), findsWidgets);
      expect(find.text('Current Streak'), findsOneWidget);
    },
  );
}
