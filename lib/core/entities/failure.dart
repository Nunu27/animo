class Failure extends Error {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
