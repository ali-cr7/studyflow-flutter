import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:study_planner/shared/domain/repositories/subject_repository.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit(this._repository) : super(SubjectsInitial());

  final SubjectRepository _repository;

  Future<void> loadSubjects() async {
    emit(SubjectsLoading());
    try {
      final items = await _repository.getAll();
      emit(SubjectsLoaded(List.unmodifiable(items)));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }

  Future<void> saveSubject(Subject subject) async {
    try {
      final saved = await _repository.save(subject);
      final current = state is SubjectsLoaded
          ? (state as SubjectsLoaded).subjects
          : <Subject>[];
      final existingIndex = current.indexWhere((s) => s.id == saved.id);
      final updated = List<Subject>.from(current);

      if (existingIndex >= 0) {
        updated[existingIndex] = saved;
      } else {
        updated.add(saved);
      }

      emit(SubjectsLoaded(List.unmodifiable(updated)));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }

  Future<void> deleteSubject(int id) async {
    try {
      await _repository.delete(id);
      final current = state is SubjectsLoaded
          ? (state as SubjectsLoaded).subjects
          : <Subject>[];
      final updated = current.where((s) => s.id != id).toList(growable: false);
      emit(SubjectsLoaded(List.unmodifiable(updated)));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }
}
