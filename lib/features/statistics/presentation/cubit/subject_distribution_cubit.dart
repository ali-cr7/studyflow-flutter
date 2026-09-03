import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectDistributionCubit extends Cubit<int?> {
  SubjectDistributionCubit() : super(null);

  void selectSection(int index) {
    emit(state == index ? null : index);
  }

  void clearSelection() {
    emit(null);
  }
}