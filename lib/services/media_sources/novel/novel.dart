import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/content_data.dart';
import 'package:animo/models/content/text_content.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/models/sync_data.dart';
import 'package:animo/services/media_sources/novel/novel_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart';

final novelProvider = Provider((ref) {
  return NovelProvider(ref);
});

class NovelProvider extends MediaProvider<TextContent> {
  // ignore: unused_field
  final Ref _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.novel,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  NovelProvider(this._ref)
      : super(
          name: 'Novel',
          type: MediaType.novel,
          mediaQueryKey: 's',
          mediaFilters: [],
        );

  @override
  Future<List<MediaBasic>> basicSearch(String query) async {
    final response = await _dio.post<String>('/wp-admin/admin-ajax.php', data: {
      'action': 'nd_ajaxsearchmain',
      'strType': 'desktop',
      'strOne': query,
      'strSearchType': 'series',
    });
    final document = parse(response.data);

    return document
        .querySelectorAll('.a_search')
        .map(formatNovelBasicSearch)
        .toList();
  }

  @override
  Future<PaginatedData<MediaBasic>> filter(
    Map<String, dynamic> options, {
    int page = 1,
  }) async {
    options['pg'] = page;

    final response = await _dio.post<String>(
      options[mediaQueryKey] == null ? '/series-finder/' : '/',
      queryParameters: options,
    );
    final document = parse(response.data);

    return PaginatedData(
      currentPage: page,
      haveMore: document.querySelector('.next_page') != null,
      data: document
          .querySelectorAll('.search_main_box_nu')
          .map(formatNovelFilter)
          .toList(),
    );
  }

  @override
  Future<Media> getMedia(SyncData syncData) {
    // TODO: implement getMedia
    throw UnimplementedError();
  }

  @override
  Future<PaginatedData<MediaContent>> getMediaContents(
    SyncData syncData, {
    int page = 1,
    Map<String, dynamic> options = const {},
  }) async {
    // TODO: implement getMediaContents
    throw UnimplementedError();
  }

  @override
  Future<ContentData<TextContent>> getContent(
    BaseData baseContent, {
    List<MediaContent>? contents,
  }) async {
    // TODO: implement getContent
    throw UnimplementedError();
  }
}
