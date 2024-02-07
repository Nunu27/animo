// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoSource {
  final String quality;
  final String url;
  final String? originalUrl;

  VideoSource({required this.quality, required this.url, this.originalUrl});

  @override
  String toString() =>
      'VideoSource(quality: $quality, url: $url, originalUrl: $originalUrl)';
}
