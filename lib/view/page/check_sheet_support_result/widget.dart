import 'package:family_notes/util/launch.dart';
import 'package:family_notes/view/component/gradation_layout/widget.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/home_button/widget.dart';

/// サポートチェックシート入力結果画面
class CheckSheetSupportResultPage extends ConsumerWidget {
  const CheckSheetSupportResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Todo: すいすいシートのURLに変更する
    const linkUrl = 'https://www.harumin-shufu.com/flutter%e3%83%a1%e3%83%a2/';

    return GradationLayout(
      title: 'チェックシート',
      showDrawer: false,
      automaticallyImplyLeading: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'お子さまの発達や行動に関して、ご心配なことがありましたら、すいすいシートも活用してみてみましょう。（ダミーテキスト）',
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: IHSColors.pink400,
                        size: 32,
                      ),
                      Text(
                        'すいすいシート',
                        style: IHSTextStyle.small.copyWith(
                          color: IHSColors.pink400,
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          text: linkUrl,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await UrlLaunch.launchInBrowser(context, linkUrl);
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              const HomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
