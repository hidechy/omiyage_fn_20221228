import 'package:family_notes/view/component/ihs_button/type.dart';
import 'package:family_notes/view/component/ihs_button/widget.dart';
import 'package:family_notes/view/component/main_layout/widget.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  //TODO: 正しいアドレスに修正
  String get contactAdress => 'xxxx.xxxxx@xxxxxxxxx.co.jp';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'お問い合わせ',
      showDrawer: false,
      body: Column(
        children: [
          const SizedBox(height: 48),
          Text(
            'お問い合わせ',
            textAlign: TextAlign.center,
            style: IHSTextStyle.medium,
          ),
          const SizedBox(height: 32),
          Text(
            'アプリの利用に関するお問い合わせ\n改善のご要望等を受け付けております。 お客様やお子さまのお体に関する\nお悩み、健康相談に関しましては、\nお答えできませんのでご了承ください。',
            textAlign: TextAlign.center,
            style: IHSTextStyle.small,
          ),
          const SizedBox(height: 32),
          Text(
            'お問合せ先：\n$contactAdress',
            textAlign: TextAlign.center,
            style: IHSTextStyle.small,
          ),
          const SizedBox(height: 32),
          Text(
            '数日以内にお返事いたします。',
            textAlign: TextAlign.center,
            style: IHSTextStyle.small,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 143,
            child: IHSButton(
              '戻る',
              type: IHSButtonType.gray,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
