import 'package:study_planner/shared/data/database/collections/study_session_collection.dart';
import 'package:study_planner/shared/domain/entities/study_session.dart';

abstract final class StudySessionMapper {
  static StudySession toDomain(StudySessionCollection collection) {
    return StudySession(
      id: collection.id,
      subjectId: collection.subjectId,
      startTime: collection.startTime,
      endTime: collection.endTime,
      duration: collection.duration,
      completed: collection.completed,
      notes: collection.notes,
    );
  }

  static StudySessionCollection toCollection(StudySession session) {
    final collection = StudySessionCollection()
      ..subjectId = session.subjectId
      ..startTime = session.startTime
      ..endTime = session.endTime
      ..duration = session.duration
      ..completed = session.completed
      ..notes = session.notes;

    if (session.id != 0) {
      collection.id = session.id;
    }

    return collection;
  }
}
