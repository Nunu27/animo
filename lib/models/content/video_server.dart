enum StreamingServer {
  vidCloud,
  vidStreaming,
  streamSB,
  streamTape,
  unsupported
}

class VideoServer {
  final String url;
  final StreamingServer server;

  VideoServer({
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
  String toString() => 'VideoServer(url: $url, server: $server)';

  @override
  bool operator ==(covariant VideoServer other) {
    if (identical(this, other)) return true;

    return other.url == url && other.server == server;
  }

  @override
  int get hashCode => url.hashCode ^ server.hashCode;
}
