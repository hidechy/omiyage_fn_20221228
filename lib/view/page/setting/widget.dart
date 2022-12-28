// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';

import '/util/util.dart';
import '../../../provider/user/notifier.dart';
import '../../component/base_app_bar/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../service/navigation.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../children_info_list/widget.dart';
import '../profile_info/widget.dart';
import '../setting_cancel_member_complete/widget.dart';
import '../setting_notification/widget.dart';
import 'type.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  List<SettingItemType> get itemTypes => [
        SettingItemType.childSelect,
        SettingItemType.profile,
        SettingItemType.notification,
        SettingItemType.kokuzixyun,
        SettingItemType.logout,
        SettingItemType.withdrawal,
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: IHSColors.pink100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: IHSColors.pink500),
        title: Text(
          '設定',
          style: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink500,
          ),
        ),
        leading: const AppBarLeadingIconButton(),
      ),
      body: GroupedListView<SettingItemType, String>(
        elements: itemTypes,
        groupBy: (element) => element.group,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: EdgeInsets.zero,
          child: ColoredBox(
            color: IHSColors.pink100,
            child: Text(
              ' ',
              style: IHSTextStyle.medium,
            ),
          ),
        ),
        itemBuilder: (c, type) {
          return ListTile(
            contentPadding: const EdgeInsets.only(
              left: 24,
              right: 16,
            ),
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: IHSColors.black200,
              ),
            ),
            tileColor: IHSColors.white,
            title: Text(type.title, style: IHSTextStyle.small),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () => _push(context, ref, type),
          );
        },
      ),
    );
  }

  void _push(BuildContext context, WidgetRef ref, SettingItemType type) {
    switch (type) {
      case SettingItemType.childSelect:
        _toChildrenInfo(context, ref);
        break;
      case SettingItemType.profile:
        _toProfile(context, ref);
        break;
      case SettingItemType.notification:
        _toNotification(context, ref);
        break;
      case SettingItemType.kokuzixyun:
        // TODO 「国循データプラットフォーム連携・解除」メニューの挙動を記述
        break;
      case SettingItemType.logout:
        IHSDialog(
            context: context,
            title: 'ログアウトします。\nよろしいですか？',
            okStr: 'ログアウト',
            cancelStr: 'キャンセル',
            onTap: (_) {
              _onTapedLogout(context, ref);
            }).showAlert();
        break;
      case SettingItemType.withdrawal:
        IHSDialog(
            context: context,
            title: '退会した場合、\n全てのデータが消去されます。\nよろしいですか？',
            okStr: '退会する',
            cancelStr: 'キャンセル',
            onTap: (_) {
              _onTapedCancel(context, ref);
            }).showAlert();
        break;
    }
  }

  // お子さま登録編集
  void _toChildrenInfo(BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ChildrenInfoListPage(),
      ),
    );
  }

  // プロフィール
  void _toProfile(BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ProfileInfoPage(),
      ),
    );
  }

  // 通知
  void _toNotification(BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SettingNotificationPage(),
      ),
    );
  }

  // ログアウト
  void _onTapedLogout(BuildContext context, WidgetRef ref) {
    ref.read(userStateProvider.notifier).logout(
      onFailure: (msg) {
        Navigator.pop(context);
        IHSUtil.showSnackBar(msg: msg);
      },
      onSuccess: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        IHSDialog(
          context: NavigationService.navigatorKey.currentContext!,
          title: 'ログアウトしました。',
          okStr: '確認',
        ).showAlert();
      },
    );
  }

  // 退会
  void _onTapedCancel(BuildContext context, WidgetRef ref) {
    ref.read(userStateProvider.notifier).cancel(
      onSuccess: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                const SettingCancelMemberCompletePage(),
          ),
        );
      },
      onFailure: (msg) {
        Navigator.of(context).pop();
        IHSUtil.showSnackBar(msg: msg);
      },
    );
  }
}
