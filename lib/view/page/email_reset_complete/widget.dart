import 'package:family_notes/view/style/colors.dart';
import 'package:flutter/material.dart';

import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../style/text_style.dart';

/// メアド変更完了画面
class EmailResetCompletedPage extends StatelessWidget {
  const EmailResetCompletedPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: false,
      body: Column(
        children: [
          const SizedBox(height: 62),
          Text(
            'メールアドレスが変更されました',
            style: IHSTextStyle.medium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'メールアドレスの変更が完了しました。',
            style: IHSTextStyle.small,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            email,
            style: IHSTextStyle.medium.copyWith(
              color: IHSColors.pink500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          IHSButton(
            'プロフィールへ',
            type: IHSButtonType.primary,
            onPressed: () {
              // TODO(miura): このタイミングでプロフィール情報の再更新を実施する
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
