import 'package:animo/domain/enums/streaming_server.dart';
import 'package:equatable/equatable.dart';

class VideoServer extends Equatable {
  final String url;
  final StreamingServer server;

  const VideoServer({
    required this.url,
    required this.server,
  });

  VideoServer copyWith({
    String? url,
    StreamingServer? server,
  }) {
    return VideoServer(
      url: url ?? this.url,
      server: server ?? this.server,
    );
  }

  factory VideoServer.fromMap(Map<String, dynamic> map) {
    return VideoServer(
      url: map['url'] as String,
      server: StreamingServer.values.byName(map['server']),
    );
  }

  @override
  List<Object> get props => [url, server];
}
