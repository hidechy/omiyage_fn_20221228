import 'package:family_notes/view/component/main_layout/widget.dart';
import 'package:flutter/material.dart';

import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../style/text_style.dart';

/// パスワードリセット完了画面
/// - 設定画面から実施する方
class SettingPasswordResetCompletedPage extends StatelessWidget {
  const SettingPasswordResetCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: false,
      body: Column(
        children: [
          const SizedBox(height: 48),
          Text(
            'パスワードが変更されました',
            textAlign: TextAlign.center,
            style: IHSTextStyle.medium,
          ),
          const SizedBox(height: 32),
          Text(
            'パスワードの変更が完了しました。',
            textAlign: TextAlign.center,
            style: IHSTextStyle.small,
          ),
          const SizedBox(height: 32),
          IHSButton(
            'プロフィールへ',
            type: IHSButtonType.primary,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
