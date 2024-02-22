import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/image_content.dart';
import 'package:animo/models/content/video_content.dart';
import 'package:flutter/foundation.dart';

import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/sync_data.dart';
import 'package:fpdart/fpdart.dart';

class ContentData<T> {
  final T data;
  final int? current;
  final List<MediaContent>? contents;

  ContentData({
    required this.data,
    required this.current,
    required this.contents,
  });

  ContentData<T> copyWith({
    SyncData? syncData,
    T? data,
    int? current,
    List<MediaContent>? contents,
  }) {
    return ContentData<T>(
      data: data ?? this.data,
      current: current ?? this.current,
      contents: contents ?? this.contents,
    );
  }

  factory ContentData.fromMap(
    Map<String, dynamic> map,
    MediaType type,
  ) {
    return ContentData<T>(
      data: _parseData(type, map['data']),
      current: map['current'] != null ? map['current'] as int : null,
      contents: map['contents'] != null
          ? List<MediaContent>.from(
              (map['contents'] as List).mapWithIndex<MediaContent?>(
                (x, index) => MediaContent.fromMap(
                  x as Map<String, dynamic>,
                  index: index,
                ).copyWith(
                  index: index,
                ),
              ),
            )
          : null,
    );
  }

  static dynamic _parseData(MediaType type, dynamic data) {
    return switch (type) {
      MediaType.anime => VideoContent.fromMap(data),
      MediaType.manga =>
        (data as List).map((e) => ImageContent.fromMap(e)).toList(),
      MediaType.novel => data as String,
    };
  }

  @override
  String toString() {
    return 'ContentData(data: $data, current: $current, contents: $contents)';
  }

  @override
  bool operator ==(covariant ContentData<T> other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.current == current &&
        listEquals(other.contents, contents);
  }

  @override
  int get hashCode {
    return data.hashCode ^ current.hashCode ^ contents.hashCode;
  }
}
