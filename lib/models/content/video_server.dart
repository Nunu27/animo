enum StreamingServer {
  vidCloud,
  vidStreaming,
  streamSB,
  streamTape,
  unsupported
}

class VideoServer {
  final int id;
  final StreamingServer server;

  VideoServer({
    required this.id,
    required this.server,
  });

  VideoServer copyWith({
    int? id,
    StreamingServer? server,
  }) {
    return VideoServer(
      id: id ?? this.id,
      server: server ?? this.server,
    );
  }

  factory VideoServer.fromMap(Map<String, dynamic> map) {
    return VideoServer(
      id: map['id'] as int,
      server: StreamingServer.values.byName(map['server']),
    );
  }

  @override
  String toString() => 'VideoServer(id: $id, server: $server)';

  @override
  bool operator ==(covariant VideoServer other) {
    if (identical(this, other)) return true;

    return other.id == id && other.server == server;
  }

  @override
  int get hashCode => id.hashCode ^ server.hashCode;
}
