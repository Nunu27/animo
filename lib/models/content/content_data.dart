import 'package:flutter/foundation.dart';

import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/sync_data.dart';

class ContentData<T> {
  final SyncData parent;
  final T data;
  final int current;
  final List<MediaContent> contents;

  ContentData({
    required this.parent,
    required this.data,
    required this.current,
    required this.contents,
  });

  ContentData<T> copyWith({
    SyncData? parent,
    T? data,
    int? current,
    List<MediaContent>? contents,
  }) {
    return ContentData<T>(
      parent: parent ?? this.parent,
      data: data ?? this.data,
      current: current ?? this.current,
      contents: contents ?? this.contents,
    );
  }

  @override
  String toString() {
    return 'ContentData(parent: $parent, data: $data, current: $current, contents: $contents)';
  }

  @override
  bool operator ==(covariant ContentData<T> other) {
    if (identical(this, other)) return true;

    return other.parent == parent &&
        other.data == data &&
        other.current == current &&
        listEquals(other.contents, contents);
  }

  @override
  int get hashCode {
    return parent.hashCode ^
        data.hashCode ^
        current.hashCode ^
        contents.hashCode;
  }
}
