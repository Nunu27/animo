import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserState extends _$UserState {
  @override
  User? build() => Hive.box(BoxConstants.main).get(BoxConstants.userKey);

  void update(User? user) {
    state = user;
  }
}
