import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/identifier.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/paginated_data.dart';

abstract class MediaProvider<T> {
  Future<PaginatedData<MediaBasic>> explore(
    String path,
    Map<String, dynamic> options,
  );

  // Filter
  Future<List<MediaBasic>> basicSearch(String query);
  Future<PaginatedData<MediaBasic>> filter(Map<String, dynamic> options);

  // Media
  Future<Media> getMedia(String slug);
  Future<PaginatedData<MediaContent>> getMediaContents(
    Identifier identifier,
    Map<String, dynamic> options,
  );
  Future<ContentData<T>> getContent(
    BaseData baseContent, {
    bool withContentList = false,
    int? current,
  });

  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  ) {
    throw 'Not available from this source';
  }
}
