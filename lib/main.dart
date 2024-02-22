import 'package:animo/constants/box_constants.dart';
import 'package:animo/firebase_options.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/user.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/router.dart';
import 'package:animo/services/notification.dart';
import 'package:animo/theme/animo_theme.dart';
import 'package:animo/theme/color_schemes.g.dart';
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
  Hive.registerAdapter(MediaTypeAdapter());
  Hive.registerAdapter(MediaBasicAdapter());
  await Hive.openBox(BoxConstants.main);
  for (var type in MediaType.values) {
    await Hive.openBox<MediaBasic>(BoxConstants.library(type));
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _listenable = Hive.box(BoxConstants.main).listenable(
    keys: [BoxConstants.userKey],
  );
  void onUserChange() {
    final User? user = _listenable.value.get(BoxConstants.userKey);
    ref.read(userStateProvider.notifier).update(user);
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
      debugShowCheckedModeBanner: false,
      title: 'Animo',
      themeMode: ThemeMode.dark,
      darkTheme: const AnimoTheme(colorScheme: darkColorScheme).build(),
      theme: const AnimoTheme(colorScheme: lightColorScheme).build(),
      builder: BotToastInit(),
      routerConfig: router,
    );
  }
}
