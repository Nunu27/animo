import 'package:animo/models/abstract/provider_info.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/failure.dart';
import 'package:animo/services/media_provider/anime.dart';
import 'package:animo/services/media_provider/manga.dart';
import 'package:animo/services/media_provider/novel.dart';

Failure getError(e) {
  return Failure(e.toString());
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
