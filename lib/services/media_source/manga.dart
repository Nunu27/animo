import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mangaProvider = Provider((ref) {
  return MangaProvider();
});

// Parser

// Filter
MediaBasic formatResult(data) => MediaBasic(
      id: data['slug'],
      title: data['title'],
      cover: data['cover_url'],
      info: data['last_chapter'].toString(),
    );

// The provider

class MangaProvider extends MediaProvider {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.manga,
      // connectTimeout: const Duration(seconds: 5),
      // receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  Future<List<MediaBasic>> basicSearch({required String keyword}) async {
    return await filter(keyword: keyword, limit: 5);
  }

  @override
  Future<List<MediaBasic>> filter({
    String? genres,
    int page = 1,
    int limit = 12,
    String? country,
    String? from,
    String? to,
    bool? completed,
    String? sort,
    String? keyword,
  }) async {
    final response = await dio.get<List<dynamic>>(
      '/v1.0/search',
      queryParameters: formatQuery(
        {
          'genres': genres,
          'page': page,
          'limit': limit,
          'country': country,
          'from': from,
          'to': to,
          'tachiyomi': true,
          'completed': completed,
          'sort': sort,
          'q': keyword,
        },
      ),
    );

    return response.data!.map(formatResult).toList();
  }
}
