import 'package:animo/models/media_basic.dart';
import 'package:animo/services/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO finish up favorite manager
class FavoritesManager extends StateNotifier<List<MediaBasic>> {
  final Box _box = Hive.box('favorites');
  final ApiService _api;

  FavoritesManager({required ApiService api})
      : _api = api,
        super([]);

  void fetch() async {}
}
