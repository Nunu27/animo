import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/abstract/filter.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_character.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';

abstract class MediaProvider<T> {
  final String name;
  final MediaType type;
  final String mediaQueryKey;
  final List<Filter> mediaFilters;
  final String? contentQueryKey;
  final List<Filter>? contentFilters;

  MediaProvider({
    required this.name,
    required this.type,
    required this.mediaQueryKey,
    required this.mediaFilters,
    this.contentQueryKey,
    this.contentFilters,
  });

  Future<List<MediaBasic>> basicSearch(String query);
  Future<PaginatedData<MediaBasic>> filter(
    Map<String, dynamic> options, {
    int page = 1,
  });

  Future<Media> getMedia(SyncData syncData);
  Future<PaginatedData<MediaContent>> getMediaContents(
    SyncData syncData, {
    int page = 1,
    Map<String, dynamic> options = const {},
  });
  Future<ContentData<T>> getContent(
    BaseData baseContent, {
    List<MediaContent>? contents,
  });

  Future<PaginatedData<MediaCharacter>> getMediaCharacters(
    BaseData baseMedia,
    int page,
  ) {
    throw 'Not available from this source';
  }

  Map<String, dynamic> formatQuery(Map<String, dynamic> map) {
    return map..removeWhere((key, value) => value == null);
  }
}
