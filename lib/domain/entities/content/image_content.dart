import 'package:equatable/equatable.dart';

class ImageContent extends Equatable {
  final String url;
  final int h;
  final int w;

  const ImageContent({
    required this.url,
    required this.h,
    required this.w,
  });

  ImageContent copyWith({
    String? url,
    int? h,
    int? w,
  }) {
    return ImageContent(
      url: url ?? this.url,
      h: h ?? this.h,
      w: w ?? this.w,
    );
  }

  factory ImageContent.fromMap(Map<String, dynamic> map) {
    return ImageContent(
      url: map['url'] as String,
      h: map['h'] as int,
      w: map['w'] as int,
    );
  }

  @override
  List<Object> get props => [url, h, w];
}
