import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IHSColors.pink50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.maintenance,
              width: 100,
            ),
            const SizedBox(height: 32),
            Text(
              'メンテナンス中です',
              style: IHSTextStyle.large.copyWith(
                color: IHSColors.pink500,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '現在システムメンテナンスを 実施しております。',
              style: IHSTextStyle.small,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            //TODO 下記のメンテナンス日時はapiからの取得値を適用する
            Text(
              '2022/12/25 00:00 〜 2022/12/25 00:00',
              style: IHSTextStyle.small,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
