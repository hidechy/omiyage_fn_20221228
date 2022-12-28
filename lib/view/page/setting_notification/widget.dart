import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/util.dart';
import '../../component/base_app_bar/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'notifier.dart';

class SettingNotificationPage extends ConsumerWidget {
  const SettingNotificationPage({super.key});

  String get itemStringNotification => '通知';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingNotificationProvider);
    final notifier = ref.watch(settingNotificationProvider.notifier);
    return Scaffold(
      backgroundColor: IHSColors.pink100,
      appBar: AppBar(
        backgroundColor: IHSColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: IHSColors.pink500),
        title: Text(itemStringNotification),
        leading: const AppBarLeadingIconButton(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 24,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: IHSColors.white,
              border: Border.all(color: IHSColors.black200),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemStringNotification,
                    style: IHSTextStyle.small,
                    textAlign: TextAlign.left,
                  ),
                  Transform.scale(
                    scale: 0.85,
                    child: CupertinoSwitch(
                        activeColor: IHSColors.pink400, //ONの色
                        trackColor: IHSColors.black200, //OFFの色
                        value: state.permission,
                        onChanged: (bool value) async {
                          IHSUtil.showLoadingDialog(context);
                          await notifier.setNotificationPermission(
                              enable: value);
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
