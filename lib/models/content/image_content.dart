class ImageContent {
  final String url;
  final int h;
  final int w;

  ImageContent({
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
  String toString() => 'ImageData(url: $url, h: $h, w: $w)';

  @override
  bool operator ==(covariant ImageContent other) {
    if (identical(this, other)) return true;

    return other.url == url && other.h == h && other.w == w;
  }

  @override
  int get hashCode => url.hashCode ^ h.hashCode ^ w.hashCode;
}
