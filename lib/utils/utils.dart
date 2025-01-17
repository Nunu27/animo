import 'package:animo/constants/constants.dart';
import 'package:animo/models/abstract/provider_info.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/failure.dart';
import 'package:animo/services/media_provider/anime.dart';
import 'package:animo/services/media_provider/manga.dart';
import 'package:animo/services/media_provider/novel.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy/MM/dd');

Failure getError(error) {
  if (error is DioException) {
    return Failure(getDioErrorMessage(error));
  }

  return Failure(error.toString());
}

String getDioErrorMessage(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return 'Request Timeout';

    default:
      return 'Request failed';
  }
}

Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
  return map..removeWhere((key, value) => value == null);
}

ProviderInfo getProviderInfo(MediaType type) {
  return switch (type) {
    MediaType.anime => animeInfo,
    MediaType.manga => mangaInfo,
    MediaType.novel => novelInfo,
  };
}

String getProxyUrl(String url) {
  return 'https://wsrv.nl/?url=${Uri.encodeComponent('http://translate.google.com/translate?sl=ja&tl=en&u=${Uri.encodeComponent(url)}')}';
}

String getCountryCode(String lang) {
  final splitted = lang.split('-');
  final a = splitted.elementAt(0);
  final b = splitted.elementAtOrNull(1);

  if (b == null) return Constants.languageMap[a] ?? a;
  if (b == '419') return 'mx';

  return b;
}
