import 'package:animo/domain/enums/character_role.dart';
import 'package:equatable/equatable.dart';

class CharacterBasic extends Equatable {
  final int id;
  final String name;
  final String? cover;
  final CharacterRole role;

  const CharacterBasic({
    required this.id,
    required this.name,
    this.cover,
    required this.role,
  });

  factory CharacterBasic.fromMap(Map<String, dynamic> map) {
    return CharacterBasic(
      id: map['id'] as int,
      name: map['name'] as String,
      cover: map['cover'] != null ? map['cover'] as String : null,
      role: CharacterRole.values.byName(map['role']),
    );
  }

  @override
  List<Object?> get props => [id, name, cover, role];
}
