enum CharacterRole {
  main('Main'),
  supporting('Supporting'),
  background('Background');

  const CharacterRole(this.text);

  final String text;
}

class MediaCharacter {
  final String id;
  final String name;
  final String? cover;
  final CharacterRole role;

  MediaCharacter({
    required this.id,
    required this.name,
    this.cover,
    required this.role,
  });

  MediaCharacter copyWith({
    String? id,
    String? name,
    String? cover,
    CharacterRole? role,
  }) {
    return MediaCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'MediaCharacter(id: $id, name: $name, cover: $cover, role: $role)';
  }

  @override
  bool operator ==(covariant MediaCharacter other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.cover == cover &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ cover.hashCode ^ role.hashCode;
  }
}
