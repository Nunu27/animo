import 'package:animo/constants/url_constants.dart';
import 'package:animo/models/media_basic.dart';
import 'package:animo/models/media_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

final animeProvider = Provider((ref) {
  return AnimeProvider();
});

// Parser

// Search Basic
MediaBasic parseResult(Element e) => MediaBasic(
      id: e.attributes['href']!.substring(1).replaceFirst("?ref=search", ""),
      title: e.querySelector('h3')!.text,
      cover: e.querySelector('img')?.attributes['data-src'],
    );

// Filter
MediaBasic parseCards(Element e) => MediaBasic(
      id: e
          .querySelector('a')!
          .attributes['href']!
          .substring(1)
          .replaceFirst("?ref=search", ""),
      cover: e.querySelector('img')!.attributes['data-src'],
      title: e.querySelector('.film-name')!.text,
    );

// The provider

class AnimeProvider extends MediaProvider {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: URLConstants.anime,
    ),
  );

  @override
  Future<List<MediaBasic>> basicSearch({required String keyword}) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/ajax/search/suggest',
      queryParameters: {'keyword': keyword},
    );

    if (!response.data?['status']) return [];
    final document = parse(response.data?['html']);

    return document
        .getElementsByTagName('a')
        .where((element) => element.querySelector('.film-poster') != null)
        .map(parseResult)
        .toList();
  }

  @override
  Future<List<MediaBasic>> filter({
    String? keyword,
    String? type,
    String? status,
    String? season,
    String? sort,
    String? genres,
    int page = 1,
  }) async {
    final response = await dio.get<String>(
      keyword == null ? '/filter' : '/search',
      queryParameters: formatQuery(
        {
          'keyword': keyword,
          'type': type,
          'status': status,
          'season': season,
          'sort': sort,
          'genres': genres,
          'page': page,
        },
      ),
    );

    final document = parse(response.data);

    return document.querySelectorAll('.flw-item').map(parseCards).toList();
  }
}
