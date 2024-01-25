import 'package:animo/services/api.dart';
import 'package:animo/services/notification.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(api: ref.watch(apiServiceProvider), ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final Box _box = Hive.box('animo');
  final ApiService _api;
  final Ref _ref;

  AuthController({required ApiService api, required Ref ref})
      : _api = api,
        _ref = ref,
        super(false);

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final res = await _api.signIn(email: email, password: password);
    state = false;

    res.fold(
      (l) => BotToast.showText(text: l.message),
      (r) {
        _box.put('user', r);
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
    final res = await _api.signUp(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    state = false;

    res.fold((l) => BotToast.showText(text: l.message), (callback) {
      // TODO open OTP verification modal
    });
  }

  void forgotPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = true;
    final res = await _api.forgotPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    state = false;

    res.fold((l) => BotToast.showText(text: l.message), (callback) {
      // TODO open OTP verification modal
    });
  }

  void signOut(BuildContext context) async {
    state = true;
    await _api.updatePushToken(
      oldToken: _ref.read(notificationProvider).token,
    );
    state = false;

    _box.delete('user').then(
          (value) => context.go('/signin'),
        );
  }
}
