import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/service/firebase/core.dart';
import 'data/service/firebase/messaging.dart';
import 'view/page/splash/widget.dart';
import 'view/service/navigation.dart';
import 'view/style/colors.dart';
import 'view/style/text_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 縦固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Firebase初期設定
  await const FirebaseCoreServiceImpl().initializeApp();

  // バックグラウンド時の通知設定（Android向け）
  FirebaseMessagingServiceImpl.onBackgroundMessage();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'すいろぐ',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink500,
          ),
        ),
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
    );
  }
}
