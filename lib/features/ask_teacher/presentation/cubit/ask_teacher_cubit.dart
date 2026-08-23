import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';
import 'package:url_launcher/url_launcher.dart';

part 'ask_teacher_state.dart';

class AskTeacherCubit extends Cubit<AskTeacherState> {
  AskTeacherCubit({required this.studentName, required this.subjects})
    : super(const AskTeacherInitial()) {
    emit(const AskTeacherReady(selectedSubject: null, question: ''));
  }

  final String studentName;
  final List<Subject> subjects;

  // Replace with your actual WhatsApp number.
  // International format WITHOUT + or spaces.
  static const String teacherWhatsApp = '963937543024';

  void selectSubject(Subject? subject) {
    final current = state;

    if (current is! AskTeacherReady) return;

    emit(
      current.copyWith(selectedSubject: subject, clearSubject: subject == null),
    );
  }

  void updateQuestion(String question) {
    final current = state;

    if (current is! AskTeacherReady) return;

    emit(current.copyWith(question: question));
  }

  bool get _isValid {
    final current = state;

    if (current is! AskTeacherReady) {
      return false;
    }

    return current.selectedSubject != null &&
        current.question.trim().length >= 5;
  }

  Future<void> sendQuestion() async {
    final current = state;

    if (current is! AskTeacherReady) {
      return;
    }

    if (current.selectedSubject == null) {
      emit(const AskTeacherError('Please select a subject.'));

      // Return to ready state so the UI remains usable.
      emit(current);
      return;
    }

    if (current.question.trim().isEmpty) {
      emit(const AskTeacherError('Please write your question.'));

      emit(current);
      return;
    }

    if (current.question.trim().length < 5) {
      emit(const AskTeacherError('Please provide a little more detail.'));

      emit(current);
      return;
    }

    emit(
      AskTeacherSending(
        selectedSubject: current.selectedSubject!,
        question: current.question.trim(),
      ),
    );

    try {
      final message =
          '''
Hello Teacher Ali 👋

Student: $studentName

Subject: ${current.selectedSubject!.name}

Question:
${current.question.trim()}

Sent from Study Planner.
''';

      final encodedMessage = Uri.encodeComponent(message);

      final uri = Uri.parse(
        'https://wa.me/$teacherWhatsApp?text=$encodedMessage',
      );

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Could not open WhatsApp.');
      }

      emit(const AskTeacherSuccess());
    } catch (error) {
      emit(AskTeacherError(error.toString().replaceFirst('Exception: ', '')));

      // Restore the form after the error.
      emit(
        AskTeacherReady(
          selectedSubject: current.selectedSubject,
          question: current.question,
        ),
      );
    }
  }

  void reset() {
    emit(const AskTeacherReady(selectedSubject: null, question: ''));
  }
}
