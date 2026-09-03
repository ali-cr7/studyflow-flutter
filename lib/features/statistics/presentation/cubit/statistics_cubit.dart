import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/statistics/data/repositories/statistics_repository.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit({required this.repository})
      : super(StatisticsState.initial());

  final StatisticsRepository repository;

  Future<void> loadStatistics({required StatisticsPeriod period}) async {
    emit(StatisticsState.loading());
    try {
      final snapshot = await repository.loadStatistics(period: period);
      emit(StatisticsState.loaded(snapshot));
    } catch (_) {
      emit(StatisticsState.failure('Could not load your statistics.'));
    }
  }

  Future<void> refresh() async {
    await loadStatistics(period: state.snapshot?.period ?? StatisticsPeriod.week);
  }
}