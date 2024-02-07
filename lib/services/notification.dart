import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:animo/repositories/auth_repository.dart';

part 'notification.g.dart';

@Riverpod(keepAlive: true)
NotificationService notification(NotificationRef ref) {
  return NotificationService(ref);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'animo_main',
  'Animo main notification channel',
  importance: Importance.max,
);

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final Ref _ref;
  String? _token;

  NotificationService(this._ref);

  String? get token => _token;

  void _handleMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _plugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
            ),
          ));
    }
  }

  void onToken(String? newToken) async {
    if (newToken != null) {
      final authRepository = _ref.read(authRepositoryProvider);

      if (authRepository.token != null) {
        await authRepository.updatePushToken(
            oldToken: token, newToken: newToken);
      }
    }

    _token = newToken;
  }

  void init() async {
    FirebaseMessaging.onMessage.listen(_handleMessage);
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
    );
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _handleMessage(initialMessage);

    onToken(await _fcm.getToken());
    FirebaseMessaging.instance.onTokenRefresh.listen(onToken).onError((err) {
      BotToast.showText(text: 'Failed to retrieve notification token');
    });
  }
}
