import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/image_content.dart';
import 'package:animo/models/content/video_content.dart';
import 'package:flutter/foundation.dart';

import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/sync_data.dart';

class ContentData<T> {
  final SyncData syncData;
  final T data;
  final int? current;
  final List<MediaContent>? contents;

  ContentData({
    required this.syncData,
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
      syncData: syncData ?? this.syncData,
      data: data ?? this.data,
      current: current ?? this.current,
      contents: contents ?? this.contents,
    );
  }

  factory ContentData.fromMap(
    Map<String, dynamic> map,
    SyncData syncData,
    MediaType type,
  ) {
    return ContentData<T>(
      syncData: syncData,
      data: _parseData(type, map['data']),
      current: map['current'] != null ? map['current'] as int : null,
      contents: map['contents'] != null
          ? List<MediaContent>.from(
              (map['contents'] as List<int>).map<MediaContent?>(
                (x) => MediaContent.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  static dynamic _parseData(MediaType type, dynamic data) {
    switch (type) {
      case MediaType.anime:
        return VideoContent.fromMap(data);
      case MediaType.manga:
        return (data as List).map((e) => ImageContent.fromMap(e));
      default:
        throw UnimplementedError();
    }
  }

  @override
  String toString() {
    return 'ContentData(syncData: $syncData, data: $data, current: $current, contents: $contents)';
  }

  @override
  bool operator ==(covariant ContentData<T> other) {
    if (identical(this, other)) return true;

    return other.syncData == syncData &&
        other.data == data &&
        other.current == current &&
        listEquals(other.contents, contents);
  }

  @override
  int get hashCode {
    return syncData.hashCode ^
        data.hashCode ^
        current.hashCode ^
        contents.hashCode;
  }
}
