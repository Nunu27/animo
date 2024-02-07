// ignore_for_file: avoid_build_context_in_providers
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/constants/box_constants.dart';
import 'package:animo/providers/library_provider.dart';
import 'package:animo/repositories/auth_repository.dart';
import 'package:animo/services/notification.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  final Box _box = Hive.box(BoxConstants.main);

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  bool build() {
    return false;
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final res = await _repository.signIn(email: email, password: password);
    state = false;

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (r) {
        _box.put(BoxConstants.userKey, r);
        context.go('/explore');
      },
    );
  }

  void signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = true;
    final res = await _repository.signUp(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    state = false;

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (callback) {
        // TODO open OTP verification modal
      },
    );
  }

  void signUpWithGoogle() async {
    state = true;
    state = false;
  }

  void signUpWithAnilist() async {
    state = true;
    state = false;
  }

  void signUpWithMAL() async {
    state = true;
    state = false;
  }

  void forgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = true;
    final res = await _repository.forgotPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    state = false;

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (callback) {
        // TODO open OTP verification modal
      },
    );
  }

  void signOut(BuildContext context) async {
    state = true;
    await _repository.updatePushToken(
      oldToken: ref.read(notificationProvider).token,
    );
    state = false;
    ref.read(libraryManagerProvider).clearLocalData();

    _box.deleteAll([BoxConstants.tokenKey, BoxConstants.userKey]).then(
      (value) => context.go('/signin'),
    );
  }
}
