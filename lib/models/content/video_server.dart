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

  @override
  String toString() => 'VideoServer(id: $id, server: $server)';
}
