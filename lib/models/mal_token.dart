class MalToken {
  final String accessToken;
  final String refreshToken;

  MalToken({
    required this.accessToken,
    required this.refreshToken,
  });

  MalToken copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return MalToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  factory MalToken.fromMap(Map<String, dynamic> map) {
    return MalToken(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  @override
  String toString() =>
      'MalToken(accessToken: $accessToken, refreshToken: $refreshToken)';

  @override
  bool operator ==(covariant MalToken other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
