import 'package:animo/domain/entities/character/character_basic.dart';

class Character extends CharacterBasic {
  const Character({
    required super.id,
    required super.name,
    required super.role,
  });
}
