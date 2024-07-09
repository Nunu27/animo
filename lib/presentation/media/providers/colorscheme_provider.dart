import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
Future<ColorScheme> colorScheme(ColorSchemeRef ref, String url) {
  return ColorScheme.fromImageProvider(
      provider: CachedNetworkImageProvider(url), brightness: Brightness.dark);
}
