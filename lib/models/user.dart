import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String token;
  @HiveField(1)
  String id;
  @HiveField(2)
  String email;
  @HiveField(3)
  String username;
  @HiveField(4)
  String? anilistToken;
  @HiveField(5)
  String? avatar;

  User({
    required this.token,
    required this.id,
    required this.email,
    required this.username,
    this.anilistToken,
    this.avatar,
  });

  User copyWith({
    String? token,
    String? id,
    String? email,
    String? username,
    String? anilistToken,
    String? avatar,
  }) {
    return User(
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      anilistToken: anilistToken ?? this.anilistToken,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'email': email,
      'username': username,
      'anilistToken': anilistToken,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      anilistToken:
          map['anilistToken'] != null ? map['anilistToken'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  @override
  String toString() {
    return 'User(token: $token, id: $id, email: $email, username: $username, anilistToken: $anilistToken, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.anilistToken == anilistToken &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        id.hashCode ^
        email.hashCode ^
        username.hashCode ^
        anilistToken.hashCode ^
        avatar.hashCode;
  }
}
