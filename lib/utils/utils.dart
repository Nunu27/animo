import 'package:animo/models/abstract/media_provider.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/failure.dart';
import 'package:animo/services/media_sources/anime/anime.dart';
import 'package:animo/services/media_sources/manga/manga.dart';
import 'package:animo/services/media_sources/novel/novel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Failure getError(e) {
  return Failure(e.toString());
}

Provider<MediaProvider> getMediaProvider(MediaType type) {
  return switch (type) {
    MediaType.anime => animeProvider,
    MediaType.manga => mangaProvider,
    MediaType.novel => novelProvider,
  } as Provider<MediaProvider>;
}
