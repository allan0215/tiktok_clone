import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  runApp(ProviderScope(
    overrides: [
      playbackConfigProvider.overrideWith(() => PlaybackConfigViewModel(repository)),
    ],
    child: const TikTokApp(),
  ));
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(authRepo).isLoggedIn);
    //S.load(const Locale("en"));
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: "TikTok Clone",
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
          surfaceTintColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xffe9435a),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xffe9435a),
        brightness: Brightness.dark,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
        textTheme: Typography.whiteCupertino,
      ),
    );
  }
}
