import 'package:animo/models/base_data.dart';
import 'package:flutter/foundation.dart';

class FeedMore {
  final String path;
  final Map<String, dynamic>? options;
  final MediaType type;

  FeedMore({required this.path, required this.options, required this.type});

  FeedMore copyWith({
    String? path,
    Map<String, dynamic>? options,
    MediaType? type,
  }) {
    return FeedMore(
      path: path ?? this.path,
      options: options ?? this.options,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'options': options,
      'type': type,
    };
  }

  factory FeedMore.fromMap(Map<String, dynamic> map, MediaType type) {
    return FeedMore(
        path: map['path'] as String,
        options: map['options'] != null
            ? Map<String, dynamic>.from(map['options'] as Map<String, dynamic>)
            : null,
        type: type);
  }

  @override
  String toString() => 'FeedMore(path: $path, options: $options, type: $type)';

  @override
  bool operator ==(covariant FeedMore other) {
    if (identical(this, other)) return true;

    return other.path == path &&
        mapEquals(other.options, options) &&
        other.type == type;
  }

  @override
  int get hashCode => path.hashCode ^ options.hashCode ^ type.hashCode;
}
