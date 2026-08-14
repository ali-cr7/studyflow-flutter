part of 'subjects_cubit.dart';

sealed class SubjectsState {}

final class SubjectsInitial extends SubjectsState {}

final class SubjectsLoading extends SubjectsState {}

final class SubjectsLoaded extends SubjectsState {
  SubjectsLoaded(this.subjects);

  final List<Subject> subjects;
}

final class SubjectsError extends SubjectsState {
  SubjectsError(this.message);

  final String message;
}
