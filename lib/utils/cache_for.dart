// ignore_for_file: empty_catches

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CacheForExtension on AutoDisposeRef<Object?> {
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    try {
      onDispose(timer.cancel);
    } catch (e) {}
  }
}
