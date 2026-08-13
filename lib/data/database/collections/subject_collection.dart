import 'package:isar/isar.dart';

part 'subject_collection.g.dart';

/// A subject the student studies (e.g. Math, Physics).
@collection
class SubjectCollection {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  /// ARGB color value, e.g. `0xFF4CAF50`.
  late int color;

  /// Icon identifier (Material icon name or custom asset key).
  late String icon;
}
