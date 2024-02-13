import 'package:animo/models/feed/feed_more.dart';
import 'package:flutter/material.dart';

enum FeedType { carousel, list, multilist }

abstract class Feed<T> {
  final String title;
  final FeedType type;
  final T data;
  final FeedMore? more;

  Feed({
    required this.title,
    required this.type,
    required this.data,
    required this.more,
  });

  Widget build();

  @override
  String toString() {
    return 'Feed(title: $title, type: $type, data: $data, more: $more)';
  }

  @override
  bool operator ==(covariant Feed<T> other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.type == type &&
        other.data == data &&
        other.more == more;
  }

  @override
  int get hashCode {
    return title.hashCode ^ type.hashCode ^ data.hashCode ^ more.hashCode;
  }
}
