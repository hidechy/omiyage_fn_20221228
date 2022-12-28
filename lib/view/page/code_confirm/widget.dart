import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/provider/signup/notifier.dart';
import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/component/ihs_text_button/widget.dart';
import '/view/component/main_layout/widget.dart';
import '/view/component/validate_text_field/type.dart';
import '/view/component/validate_text_field/widget.dart';
import '/view/page/code_confirm/notifier.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';
import '../../../util/util.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../code_remind/type.dart';
import '../email_resend/widget.dart';
import '../email_reset_complete/widget.dart';
import '../sign_up/widget.dart';
import '../sign_up_completed/widget.dart';
import '../undeliverd_email/widget.dart';

/// 認証コード確認画面（アカウント新規作成orメアド変更で使用）
class CodeConfirmPage extends ConsumerWidget {
  CodeConfirmPage({
    super.key,
    required this.email,
    required this.emailSendMode,
  });

  final String email;
  // EmailSendMode.signUpの場合のみ「メールアドレスを再入力する」表示
  final EmailSendMode emailSendMode;
  final _authCodeController = getController(
    type: ValidateTextFieldType.authCode,
    value: '',
  );

  FormGroup get form => FormGroup(
        {
          ValidateTextFieldType.authCode.name: _authCodeController,
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(condeConfirmStateProvider);
    final notifier = ref.watch(condeConfirmStateProvider.notifier);

    return MainLayout(
      showAppBar: false,
      body: ReactiveForm(
        formGroup: form,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: state.saving,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      '認証コードをご確認します',
                      style: IHSTextStyle.medium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'ご登録されたメールアドレスに\nお送りした認証コードを\n入力してください',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '送付された認証コード',
                          style: IHSTextStyle.xSmall,
                        ),
                        const SizedBox(height: 8),
                        ValidateTextField(
                          type: ValidateTextFieldType.authCode,
                          controller: _authCodeController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            notifier.onChangedAuthCode(value);
                            return value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 143,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IHSButton(
                            '送信',
                            type: IHSButtonType.primary,
                            onPressed: () {
                              form.markAllAsTouched();

                              if (!form.valid) {
                                return;
                              }
                              notifier.onTappedSend(
                                email: email,
                                sendMode: emailSendMode,
                                onSuccess: () {
                                  _pushToNextPage(context);
                                },
                                onFailure: (msg) {
                                  IHSUtil.showSnackBar(msg: msg);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          IHSButton(
                            'キャンセル',
                            type: IHSButtonType.gray,
                            onPressed: () {
                              _onTappedCancel(context, ref);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    IHSTextButton(
                      '認証コードを再送信する',
                      onPressed: () {
                        notifier.onTappedCodeResend(
                          emailSendMode: emailSendMode,
                          email: email,
                          onSuccess: () {
                            IHSDialog(
                                    context: context,
                                    title: '認証コードを再送信しました',
                                    okStr: '確認',
                                    onTap: (_) {})
                                .showAlert();
                          },
                          onFailure: (msg) {
                            IHSUtil.showSnackBar(msg: msg);
                          },
                        );
                      },
                    ),
                    if (emailSendMode == EmailSendMode.signUp) ...[
                      const SizedBox(height: 32),
                      IHSTextButton(
                        'メールアドレスを再入力する',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder<void>(
                              pageBuilder: (_, __, ___) => EmailResendPage(
                                oldEmail: email,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 32),
                    IHSTextButton(
                      'メールが届かない場合はこちら',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const UndeliverdEmailPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            if (state.saving) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  void _pushToNextPage(BuildContext context) {
    switch (emailSendMode) {
      case EmailSendMode.signUp:
        // 新規アカウント作成完了画面へ
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (_, __, ___) => SignUpCompletedPage(email: email),
          ),
        );
        return;
      case EmailSendMode.resetEmail:
        // メール変更完了画面
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (_, __, ___) => EmailResetCompletedPage(email: email),
          ),
        );
        return;
      case EmailSendMode.forgettenPassword:
        // パスワードお忘れのコード認証は別画面で実施するため通らない想定
        break;
    }
  }

  void _onTappedCancel(BuildContext context, WidgetRef ref) {
    switch (emailSendMode) {
      case EmailSendMode.signUp:
        // これまでのサインアップ情報をリセット
        ref.read(signUpStateProvider.notifier).reset();
        // 戻る（サインアップ画面）
        Navigator.of(context).pushReplacement(
          PageRouteBuilder<void>(
            pageBuilder: (_, __, ___) => SignUpPage(),
          ),
        );
        return;
      case EmailSendMode.resetEmail:
        // 戻る（プロフィール入力画面）
        Navigator.of(context).pop();
        return;
      case EmailSendMode.forgettenPassword:
        // 同上
        break;
    }
  }
}
