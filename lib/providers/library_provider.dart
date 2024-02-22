import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_provider.g.dart';

@riverpod
class Library extends _$Library {
  @override
  List<MediaBasic> build(MediaType type) {
    return Hive.box<MediaBasic>(BoxConstants.library(type)).values.toList();
  }

  void add(MediaBasic value, {bool silent = true}) {
    state.add(value);
    if (!silent) ref.notifyListeners();
  }

  void remove(MediaBasic value, {bool silent = true}) {
    state.remove(value);
    if (!silent) ref.notifyListeners();
  }

  void clear() {
    state.clear();
    ref.notifyListeners();
  }

  void notify() {
    ref.notifyListeners();
  }
}
