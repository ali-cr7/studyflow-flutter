import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';

abstract class StatisticsRepository {
  Future<StatisticsSnapshot> loadStatistics({required StatisticsPeriod period});
}
