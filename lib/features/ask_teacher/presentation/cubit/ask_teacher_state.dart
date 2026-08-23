part of 'ask_teacher_cubit.dart';

@immutable


sealed class AskTeacherState {
  const AskTeacherState();
}

final class AskTeacherInitial extends AskTeacherState {
  const AskTeacherInitial();
}

final class AskTeacherReady extends AskTeacherState {
  const AskTeacherReady({
    required this.selectedSubject,
    this.question = '',
  });

  final Subject? selectedSubject;
  final String question;

  AskTeacherReady copyWith({
    Subject? selectedSubject,
    bool clearSubject = false,
    String? question,
  }) {
    return AskTeacherReady(
      selectedSubject: clearSubject
          ? null
          : selectedSubject ?? this.selectedSubject,
      question: question ?? this.question,
    );
  }
}

final class AskTeacherSending extends AskTeacherState {
  const AskTeacherSending({
    required this.selectedSubject,
    required this.question,
  });

  final Subject selectedSubject;
  final String question;
}

final class AskTeacherSuccess extends AskTeacherState {
  const AskTeacherSuccess();
}

final class AskTeacherError extends AskTeacherState {
  const AskTeacherError(this.message);

  final String message;
}