import 'package:animo/models/base_data.dart';
import 'package:animo/widgets/list_feed_view.dart';
import 'package:flutter/foundation.dart';

import 'package:animo/models/abstract/feed.dart';
import 'package:animo/models/feed/feed_more.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:flutter/material.dart';

class ListFeed extends Feed<List<MediaBasic>> {
  ListFeed({
    required super.title,
    required super.type,
    required super.data,
    required super.more,
  });

  @override
  Widget build() {
    return ListFeedView(
      title: title,
      data: data,
      more: more,
    );
  }

  ListFeed copyWith({
    String? title,
    FeedType? type,
    List<MediaBasic>? data,
    FeedMore? more,
  }) {
    return ListFeed(
      title: title ?? this.title,
      type: type ?? this.type,
      data: data ?? this.data,
      more: more ?? this.more,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type.name,
      'data': data.map((x) => x.toMap()).toList(),
      'more': more?.toMap(),
    };
  }

  factory ListFeed.fromMap(Map<String, dynamic> map, MediaType type) {
    return ListFeed(
      title: map['title'] as String,
      type: FeedType.values.byName(map['type']),
      data: List<MediaBasic>.from(
        (map['data'] as List).map<MediaBasic>(
          (x) => MediaBasic.fromMap(x as Map<String, dynamic>),
        ),
      ),
      more: map['more'] != null
          ? FeedMore.fromMap(map['more'] as Map<String, dynamic>, type)
          : null,
    );
  }

  @override
  String toString() {
    return 'ListFeed(title: $title, type: $type, data: $data, more: $more)';
  }

  @override
  bool operator ==(covariant ListFeed other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.type == type &&
        listEquals(other.data, data) &&
        other.more == more;
  }

  @override
  int get hashCode {
    return title.hashCode ^ type.hashCode ^ data.hashCode ^ more.hashCode;
  }
}
