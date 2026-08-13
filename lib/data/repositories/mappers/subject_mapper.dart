import 'package:study_planner/data/database/collections/subject_collection.dart';
import 'package:study_planner/shared/domain/entities/subject.dart';

abstract final class SubjectMapper {
  static Subject toDomain(SubjectCollection collection) {
    return Subject(
      id: collection.id,
      name: collection.name,
      color: collection.color,
      icon: collection.icon,
    );
  }

  static SubjectCollection toCollection(Subject subject) {
    final collection = SubjectCollection()
      ..name = subject.name
      ..color = subject.color
      ..icon = subject.icon;

    if (subject.id != 0) {
      collection.id = subject.id;
    }

    return collection;
  }
}
