import 'package:animo/domain/entities/content/image_content.dart';
import 'package:animo/domain/entities/content/video_content.dart';
import 'package:animo/domain/entities/media/media_content.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class ContentData<T> extends Equatable {
  final T data;
  final int? current;
  final List<MediaContent>? contents;

  const ContentData({
    required this.data,
    required this.current,
    required this.contents,
  });

  ContentData<T> copyWith({
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
      MediaType.ANIME => VideoContent.fromMap(data),
      MediaType.MANGA =>
        (data as List).map((e) => ImageContent.fromMap(e)).toList(),
      MediaType.NOVEL => data as String,
    };
  }

  @override
  List<Object?> get props => [data, current, contents];
}
