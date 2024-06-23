import 'package:equatable/equatable.dart';

class VideoSource extends Equatable {
  final String quality;
  final String url;
  final String? originalUrl;

  const VideoSource({
    required this.quality,
    required this.url,
    this.originalUrl,
  });

  @override
  List<Object?> get props => [quality, url, originalUrl];
}
