import 'package:animo/models/mal_token.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String? avatar;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String? anilistToken;
  @HiveField(6)
  final MalToken? malToken;

  User({
    required this.token,
    required this.id,
    required this.avatar,
    required this.email,
    required this.username,
    required this.anilistToken,
    required this.malToken,
  });

  User copyWith({
    String? token,
    String? id,
    String? avatar,
    String? email,
    String? username,
    String? anilistToken,
    MalToken? malToken,
  }) {
    return User(
      token: token ?? this.token,
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      username: username ?? this.username,
      anilistToken: anilistToken ?? this.anilistToken,
      malToken: malToken ?? this.malToken,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      id: map['id'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      email: map['email'] as String,
      username: map['username'] as String,
      anilistToken:
          map['anilistToken'] != null ? map['anilistToken'] as String : null,
      malToken: map['malToken'] != null
          ? MalToken.fromMap(map['malToken'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() {
    return 'User(token: $token, id: $id, avatar: $avatar, email: $email, username: $username, anilistToken: $anilistToken, malToken: $malToken)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.id == id &&
        other.avatar == avatar &&
        other.email == email &&
        other.username == username &&
        other.anilistToken == anilistToken &&
        other.malToken == malToken;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        id.hashCode ^
        avatar.hashCode ^
        email.hashCode ^
        username.hashCode ^
        anilistToken.hashCode ^
        malToken.hashCode;
  }
}
