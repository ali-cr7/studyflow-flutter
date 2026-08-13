/// A school subject the student studies (e.g. Math, Biology).
class Subject {
  const Subject({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  /// Isar auto-increment id; `0` means not yet persisted.
  final int id;
  final String name;

  /// ARGB color value, e.g. `0xFF4CAF50`.
  final int color;

  /// Material icon name or custom asset key.
  final String icon;

  Subject copyWith({
    int? id,
    String? name,
    int? color,
    String? icon,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Subject &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.icon == icon;
  }

  @override
  int get hashCode => Object.hash(id, name, color, icon);
}
