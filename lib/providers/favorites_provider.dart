import 'package:animo/models/media_basic.dart';
import 'package:animo/services/api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesManager, List<MediaBasic>>((ref) {
  return FavoritesManager(api: ref.watch(apiServiceProvider));
});

class FavoritesManager extends StateNotifier<List<MediaBasic>> {
  final Box<MediaBasic> _box = Hive.box<MediaBasic>('favorites');
  final ApiService _api;

  FavoritesManager({required ApiService api})
      : _api = api,
        super([]) {
    state = _box.values.toList();
  }

  void fetch() async {
    final res = await _api.getFavorites();

    res.fold((l) => BotToast.showText(text: l.message), (r) => state = r);
  }

  void import() async {
    // TODO import backup data from anilist and mal
  }

  void add(List<MediaBasic> list) async {
    state.addAll(list);
    final res = await _api.addFavorites(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      for (var media in list) {
        state.remove(media);
      }
    }, (addedList) {
      for (var media in list) {
        if (addedList.contains(media.slug)) {
          _box.put(media.slug, media);
        } else {
          state.remove(media);
        }
      }
    });
  }

  void remove(List<MediaBasic> list) async {
    for (var media in list) {
      state.remove(media);
    }
    final res = await _api.removeFavorites(list.map((e) => e.slug).toList());

    res.fold((l) {
      BotToast.showText(text: l.message);
      state.addAll(list);
    }, (removedList) {
      _box.deleteAll(removedList);

      final notRemoved = list.filter((t) => removedList.contains(t.slug));
      state.addAll(notRemoved);
    });
  }

  void clearLocalData() {
    _box.clear();
    state.clear();
  }

  void clear() async {
    final res = await _api.clearFavorites();

    res.fold(
        (l) => BotToast.showText(text: l.message), (r) => clearLocalData());
  }
}
