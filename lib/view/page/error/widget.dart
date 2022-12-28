import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IHSColors.pink50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.error,
              width: 100,
            ),
            const SizedBox(height: 32),
            Text(
              'ネットワークが不安定です。',
              style: IHSTextStyle.large.copyWith(
                color: IHSColors.pink500,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '電波の安定したところで\n再度お試しください。',
              style: IHSTextStyle.small,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
