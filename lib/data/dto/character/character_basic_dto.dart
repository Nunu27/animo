import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/enums/character_role.dart';

class CharacterBasicDto extends CharacterBasic {
  const CharacterBasicDto({
    required super.id,
    required super.name,
    required super.role,
    required super.cover,
  });

  factory CharacterBasicDto.fromAnilist(Map<String, dynamic> data) {
    return CharacterBasicDto(
      id: data['node']['id'],
      name: data['node']['name']['userPreferred'],
      cover: data['node']['image']['medium'],
      role: CharacterRole.values.byName(data['role']),
    );
  }
}
