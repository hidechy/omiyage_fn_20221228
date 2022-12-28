import 'package:family_notes/view/page/password_reset_code_input/widget.dart';
import 'package:flutter/material.dart';

import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/component/main_layout/widget.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';
import '../code_confirm/widget.dart';
import 'type.dart';

/// 「認証コードをご確認ください」画面
class CodeRemindPage extends StatelessWidget {
  const CodeRemindPage({
    super.key,
    required this.email,
    required this.emailSendMode,
  });

  final String email;
  final EmailSendMode emailSendMode;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: false,
      body: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            '認証コードをご確認ください',
            style: IHSTextStyle.medium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'ご登録されたメールアドレスに\n認証コードを送信しました',
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
          SizedBox(
            width: 143,
            child: IHSButton(
              '次へ',
              type: IHSButtonType.primary,
              onPressed: () {
                _onTapNextButton(context);
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '※ 迷惑メールフォルダやゴミ箱に自動的に\n振り分けられている可能性がありますので、\n一度ご確認いただきます様お願いいたします。',
            style: IHSTextStyle.xSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _onTapNextButton(BuildContext context) async {
    switch (emailSendMode) {
      case EmailSendMode.signUp:
      case EmailSendMode.resetEmail:
        await Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (_, __, ___) => CodeConfirmPage(
              email: email,
              emailSendMode: emailSendMode,
            ),
          ),
        );
        break;
      case EmailSendMode.forgettenPassword:
        await Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (_, __, ___) => PasswordResetCodeInputPage(
              email: email,
            ),
          ),
        );
        break;
    }
  }
}
