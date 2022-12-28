import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/gen/assets.gen.dart';
import '/provider/user/notifier.dart';
import '/util/util.dart';
import '/view/component/ihs_dialog/widget.dart';
import '/view/style/colors.dart';
import '../../../provider/config/notifier.dart';
import '../root/widget.dart';
import 'version_check.dart';

///  認証が通っている時だけ、各種バージョンのチェックを行う
///  バージョンチェック後、下記のようにページ遷移
///  母子手帳未選択の場合: BookSelectPage
///  ログイン済みの場合：　BottomBarPage

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configStateNotifier = ref.watch(appConfigProvider.notifier);
    final userStateNotifier = ref.watch(userStateProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        await configStateNotifier.fetch(onFailure: (msg) {
          IHSUtil.showSnackBar(msg: msg);
        });
        await userStateNotifier.loadAuthenticationStatus(onFailure: (msg) {
          IHSUtil.showSnackBar(msg: msg);
        });
        await _showDialogIfNeeded(context, ref);
        await toRootPage(context);
      });
      return null;
    }, []);

    return Scaffold(
      body: ColoredBox(
        color: IHSColors.pink100,
        child: Center(
          child: Image.asset(Assets.images.splash.path),
        ),
      ),
    );
  }
}

Future<void> _showDialogIfNeeded(BuildContext context, WidgetRef ref) async {
// ダイアログで表示する文字列
  const appAlertMessage = '新しいバージョンがリリースされました\nアプリをアップデートしてください。';

  final checkAppVersion =
      await ref.read(versionCheckProvider).checkAppVersion();

  if (!checkAppVersion) {
    return IHSDialog(
      context: context,
      title: appAlertMessage,
      okStr: 'ストアへ',
    ).showAlert();
    // TODO:ストアに遷移する処理を追加(ito)
  }
}

Future<void> toRootPage(BuildContext context) async {
  Future.delayed(
    const Duration(seconds: 2),
    () => Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const RootPage(),
      ),
    ),
  );
}
