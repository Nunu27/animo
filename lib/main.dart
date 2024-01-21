import 'package:animo/firebase_options.dart';
import 'package:animo/models/user.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/router.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/theme/pallete.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('animo');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _listenable = Hive.box('animo').listenable(keys: ['user']);
  void onUserChange() {
    ref
        .read(userProvider.notifier)
        .update((state) => _listenable.value.get('user'));
  }

  @override
  void initState() {
    super.initState();
    ref.read(notificationProvider).init();
    _listenable.addListener(onUserChange);
  }

  @override
  void dispose() {
    _listenable.removeListener(onUserChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Animo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Pallete.primary,
          background: Pallete.background,
          brightness: Brightness.dark,
        ),
      ),
      builder: BotToastInit(),
      routerConfig: router,
    );
  }
}