import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/view/page/login/widget.dart';
import '/view/page/maintenance/widget.dart';
import '../../../data/service/firebase/messaging.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../provider/user/notifier.dart';
import '../bottom_bar/widget.dart';
import '../child_book_select/widget.dart';

class RootPage extends StatefulHookConsumerWidget {
  const RootPage({super.key});

  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends ConsumerState<RootPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maintenanceState = ref.watch(maintenanceStateProvider);
    final userState = ref.watch(userStateProvider);
    ref.read(firebaseMessagingServiceProvider).initialize(
      onLoadedToken: (token) {
        // TODO(miura): このtokenをAPIに保存する。tokenはユーザーに紐づくのでauthenticated
        //  になってからこのinitializeを呼ぶようにした方がいいかも。
        debugPrint('FCM Token: $token');
      },
    );

    return maintenanceState.map(
      off: (_) => userState.map(
        init: (_) => throw Exception('SplashPageで認証状態を判定してから遷移してください'),
        unauthenticated: (_) => LoginPage(),
        authenticated: (UserStateAuthenticated state) {
          final selectedChildId = state.selectedChildId;
          if (selectedChildId == null) {
            return const ChildBookSelectPage(showDrawer: false);
          }
          return const BottomBarPage();
        },
      ),
      on: (_) => const MaintenancePage(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      // 非アクティブ
      case AppLifecycleState.inactive:
        break;
      // 停止
      case AppLifecycleState.paused:
        break;
      // 再開
      case AppLifecycleState.resumed:
        ref.read(maintenanceStateProvider.notifier).reloadIfNeeded();
        break;
      // 破棄
      case AppLifecycleState.detached:
        break;
    }
  }
}
