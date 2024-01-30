import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/services/api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

final libraryProvider = Provider((ref) {
  return LibraryManager(api: ref.watch(apiServiceProvider), ref: ref);
});

final animeLibraryProvider = StateProvider<List<MediaBasic>>((ref) => []);
final mangaLibraryProvider = StateProvider<List<MediaBasic>>((ref) => []);
final novelLibraryProvider = StateProvider<List<MediaBasic>>((ref) => []);

StateProvider<List<MediaBasic>> getMediaLibrary(MediaType type) {
  switch (type) {
    case MediaType.anime:
      return animeLibraryProvider;
    case MediaType.manga:
      return mangaLibraryProvider;
    case MediaType.novel:
      return novelLibraryProvider;
  }
}

final isInLibraryProvider = StateProvider.family((ref, BaseData baseMedia) {
  ref.watch(getMediaLibrary(baseMedia.type));

  return Hive.box(BoxConstants.library).containsKey(baseMedia.slug);
});

class LibraryManager {
  final Box<MediaBasic> _box = Hive.box<MediaBasic>(BoxConstants.library);
  final ApiService _api;
  final Ref _ref;

  LibraryManager({required ApiService api, required Ref ref})
      : _api = api,
        _ref = ref;

  void fetch() async {
    final res = await _api.getLibrary();

    res.fold((l) => BotToast.showText(text: l.message), (library) {
      final slugs = [];

      for (var media in library) {
        slugs.add(media.slug);
        if (!_box.containsKey(media.slug)) {
          _box.put(media.slug, media);
        }
      }

      for (var key in _box.keys) {
        if (!slugs.contains(key) && _box.containsKey(key)) {
          final media = _box.get(key)!;

          _ref.read(getMediaLibrary(media.type)).remove(media);
          _box.delete(key);
        }
      }
    });
  }

  void import() async {
    // TODO import backup data from anilist and mal
  }

  void add(List<MediaBasic> list) async {
    for (var media in list) {
      _ref.read(getMediaLibrary(media.type)).add(media);
    }
    final res = await _api.addToLibrary(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      for (var media in list) {
        _ref.read(getMediaLibrary(media.type)).remove(media);
      }
    }, (addedList) {
      for (var media in list) {
        if (addedList.contains(media.slug)) {
          _box.put(media.slug, media);
        } else {
          _ref.read(getMediaLibrary(media.type)).remove(media);
        }
      }
    });
  }

  void remove(List<MediaBasic> list) async {
    for (var media in list) {
      _ref.read(getMediaLibrary(media.type)).remove(media);
    }
    final res = await _api.removeFromLibrary(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      for (var media in list) {
        _ref.read(getMediaLibrary(media.type)).add(media);
      }
    }, (removedList) {
      _box.deleteAll(removedList);

      final notRemoved = list.filter((t) => removedList.contains(t.slug));
      for (var media in notRemoved) {
        _ref.read(getMediaLibrary(media.type)).add(media);
      }
    });
  }

  void clearLocalData() {
    _box.clear();
    for (var type in MediaType.values) {
      _ref.read(getMediaLibrary(type)).clear();
    }
  }

  void clear() async {
    final res = await _api.clearLibrary();

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (r) => clearLocalData(),
    );
  }
}
