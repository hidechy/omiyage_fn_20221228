// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<FirebaseMessagingService> firebaseMessagingServiceProvider =
    Provider<FirebaseMessagingService>(
  (_) {
    final messaging = FirebaseMessaging.instance;
    return FirebaseMessagingServiceImpl(
      messaging: messaging,
    );
  },
);

abstract class FirebaseMessagingService {
  /// 通知サービスの初期化
  Future<void> initialize({
    required Function(String) onLoadedToken,
  });

  /// FCM トークンを取得
  Future<String?> getFCMToken();

  /// (iOS のみ) APNs トークンを取得
  Future<String?> getAPNsToken();
}

class FirebaseMessagingServiceImpl implements FirebaseMessagingService {
  const FirebaseMessagingServiceImpl({
    required this.messaging,
  });

  final FirebaseMessaging messaging;

  @override
  Future<void> initialize({
    required Function(String) onLoadedToken,
  }) async {
    await messaging.requestPermission().then(
      (settings) {
        if (settings.authorizationStatus != AuthorizationStatus.authorized) {
          debugPrint('通知が許可されていません');
        }
      },
    );

    // フォアグランド設定（iOS向け）
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// LocalNotification設定（Android向け）
    await FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        // TODO: 正式なアイコンを適応する
        android: AndroidInitializationSettings('alert'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');

        showLocalNotification(message);
      },
    );

    final token = await messaging.getToken();
    if (token != null) {
      onLoadedToken(token);
    }
  }

  @override
  Future<String?> getFCMToken() async {
    final fcmToken = await messaging.getToken();

    if (fcmToken != null) {
      debugPrint('Succeed fetch FCM token: $fcmToken');
    } else {
      debugPrint('FCM token is null');
    }
    return fcmToken;
  }

  @override
  Future<String?> getAPNsToken() async {
    final apnsToken = await messaging.getAPNSToken();

    if (apnsToken != null) {
      debugPrint('Succeed fetch APNs token: $apnsToken');
    } else {
      debugPrint('APNs token is null');
    }
    return apnsToken;
  }

  /// バックグランド設定
  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
  }

  static void showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin().show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.high,
            priority: Priority.high,
            enableLights: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}
