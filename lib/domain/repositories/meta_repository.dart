import 'package:animo/domain/entities/character/character.dart';
import 'package:animo/domain/entities/feed.dart';
import 'package:animo/domain/entities/media/media.dart';
import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/entities/character/character_basic.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/domain/enums/media_type.dart';

abstract class MetaRepository {
  Future<Feed> getFeed(MediaType type);
  Future<PaginatedData<MediaBasic>> filter();
  Future<Media> getDetail(int id);

  Future<PaginatedData<MediaBasic>> getMediaRelations(
    int id, [
    int page = 1,
  ]);
  Future<PaginatedData<CharacterBasic>> getMediaCharacters(
    int id, [
    int page = 1,
  ]);

  Future<Character> getCharacter(int id);
  Future<MediaBasic> getCharacterMedia(
    int id, [
    MediaType? type,
    int page = 1,
  ]);
}
