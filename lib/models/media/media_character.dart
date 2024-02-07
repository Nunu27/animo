import 'package:animo/models/abstract/mappable.dart';

enum CharacterRole {
  main('Main'),
  supporting('Supporting'),
  background('Background');

  const CharacterRole(this.text);

  final String text;
}

class MediaCharacter implements Mappable {
  final String slug;
  final String name;
  final String? cover;
  final CharacterRole role;

  MediaCharacter({
    required this.slug,
    required this.name,
    this.cover,
    required this.role,
  });

  MediaCharacter copyWith({
    String? slug,
    String? name,
    String? cover,
    CharacterRole? role,
  }) {
    return MediaCharacter(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slug': slug,
      'name': name,
      'cover': cover,
      'role': role.name,
    };
  }

  factory MediaCharacter.fromMap(Map<String, dynamic> map) {
    return MediaCharacter(
      slug: map['slug'] as String,
      name: map['name'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      role: CharacterRole.values.byName(map['role']),
    );
  }

  @override
  String toString() {
    return 'MediaCharacter(slug: $slug, name: $name, cover: $cover, role: $role)';
  }

  @override
  bool operator ==(covariant MediaCharacter other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.name == name &&
        other.cover == cover &&
        other.role == role;
  }

  @override
  int get hashCode {
    return slug.hashCode ^ name.hashCode ^ cover.hashCode ^ role.hashCode;
  }
}
