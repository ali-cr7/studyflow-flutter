import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/features/statistics/data/repositories/statistics_repository.dart';
import 'package:study_planner/features/statistics/presentation/cubit/statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit({required StatisticsRepository repository})
    : _repository = repository,
      super(StatisticsState.initial());

  final StatisticsRepository _repository;

  Future<void> loadStatistics({
    StatisticsPeriod period = StatisticsPeriod.week,
  }) async {
    emit(StatisticsState.loading());

    try {
      final snapshot = await _repository.loadStatistics(period: period);
      if (snapshot.subjectBreakdown.isEmpty && snapshot.studyMinutes == 0) {
        emit(StatisticsState.empty());
        return;
      }
      emit(StatisticsState.loaded(snapshot));
    } catch (_) {
      emit(StatisticsState.failure('Could not load your statistics.'));
    }
  }
}
