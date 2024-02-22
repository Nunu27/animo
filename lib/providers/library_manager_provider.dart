import 'package:animo/providers/library_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/repositories/library_repository.dart';

part 'library_manager_provider.g.dart';

@riverpod
LibraryManager libraryManager(LibraryManagerRef ref) {
  return LibraryManager(
      ref: ref, repository: ref.watch(libraryRepositoryProvider));
}

@riverpod
bool isInLibrary(
  IsInLibraryRef ref, {
  required String slug,
  required MediaType type,
}) {
  return ref.watch(libraryProvider(type)).any((media) => media.slug == slug);
}

class LibraryManager {
  final LibraryManagerRef _ref;
  final Map<MediaType, Box<MediaBasic>> _boxs = {};
  final LibraryRepository _repository;

  LibraryManager(
      {required LibraryManagerRef ref, required LibraryRepository repository})
      : _ref = ref,
        _repository = repository {
    for (var type in MediaType.values) {
      _boxs[type] = Hive.box(BoxConstants.library(type));
    }
  }

  Library? _getState(MediaType type) {
    final provider = libraryProvider(type);
    if (!_ref.exists(provider)) return null;

    return _ref.read(provider.notifier);
  }

  void notify() {
    for (var type in MediaType.values) {
      _getState(type)?.notify();
    }
  }

  void fetch() async {
    final res = await _repository.getLibrary();

    res.fold((l) => BotToast.showText(text: l.message), (library) {
      final slugs = [];

      for (var media in library) {
        slugs.add(media.slug);
        if (!_boxs[media.type]!.containsKey(media.slug)) {
          _boxs[media.type]!.put(media.slug, media);
        }
      }

      for (var type in MediaType.values) {
        final box = _boxs[type]!;

        for (var key in box.keys) {
          if (!slugs.contains(key) && box.containsKey(key)) {
            final media = box.get(key)!;

            _getState(media.type)?.remove(media);
            box.delete(key);
          }
        }
      }
    });
    notify();
  }

  void import() async {
    // TODO import backup data from anilist and mal
  }

  void add(List<MediaBasic> list) async {
    for (var media in list) {
      _getState(media.type)?.add(media);
    }
    notify();

    final res =
        await _repository.addToLibrary(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      for (var media in list) {
        _getState(media.type)?.remove(media);
      }
    }, (addedList) {
      for (var media in list) {
        if (addedList.contains(media.slug)) {
          _boxs[media.type]!.put(media.slug, media);
        } else {
          _getState(media.type)?.remove(media);
        }
      }
    });
    notify();
  }

  void remove(List<MediaBasic> list) async {
    for (var media in list) {
      _getState(media.type)?.remove(media);
    }
    notify();

    final res =
        await _repository.removeFromLibrary(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      for (var media in list) {
        _getState(media.type)?.add(media);
      }
    }, (removedList) {
      for (var type in MediaType.values) {
        _boxs[type]!.deleteAll(removedList);
      }

      final notRemoved = list.filter((t) => removedList.contains(t.slug));
      for (var media in notRemoved) {
        _getState(media.type)?.add(media);
      }
    });
    notify();
  }

  void clearLocalData() {
    for (var type in MediaType.values) {
      _boxs[type]!.clear();
      _getState(type)?.clear();
    }
  }

  void clear() async {
    final res = await _repository.clearLibrary();

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (r) => clearLocalData(),
    );
  }
}
