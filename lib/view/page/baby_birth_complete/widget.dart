import 'package:flutter/material.dart';

import '/view/component/gradation_layout/widget.dart';
import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';

/// 出産情報登録完了画面
class BabybirthCompletePage extends StatelessWidget {
  const BabybirthCompletePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradationLayout(
      title: '出産情報登録',
      showDrawer: false,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'お子さまの登録が完了しました',
            style: IHSTextStyle.medium.copyWith(
              color: IHSColors.pink500,
            ),
          ),
          const SizedBox(height: 32),
          IHSButton(
            'ホームへ',
            type: IHSButtonType.primary,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
