import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/util/util.dart';
import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/component/main_layout/widget.dart';
import '/view/component/validate_text_field/type.dart';
import '/view/component/validate_text_field/widget.dart';
import '/view/page/code_remind/type.dart';
import '/view/style/text_style.dart';
import '../../component/loading_indicator/widget.dart';
import '../code_confirm/widget.dart';
import '../code_remind/widget.dart';
import 'notifier.dart';

/// メール再送画面
class EmailResendPage extends ConsumerWidget {
  EmailResendPage({
    super.key,
    required this.oldEmail,
  });

  final String oldEmail;
  final _emailController =
      getController(type: ValidateTextFieldType.email, value: '');

  FormGroup get form => FormGroup(
        {
          ValidateTextFieldType.email.name: _emailController,
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(emailResendStateProvider);
    final notifier = ref.watch(emailResendStateProvider.notifier);
    return MainLayout(
      showAppBar: false,
      body: ReactiveForm(
        formGroup: form,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: state.sending,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'メールアドレスを再入力する',
                      textAlign: TextAlign.center,
                      style: IHSTextStyle.medium,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '入力されたメールアドレスに\n認証コードを再送信します',
                      textAlign: TextAlign.center,
                      style: IHSTextStyle.small,
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'メールアドレス',
                          style: IHSTextStyle.xSmall,
                        ),
                        const SizedBox(height: 8),
                        ValidateTextField(
                          type: ValidateTextFieldType.email,
                          hintText: 'example@test.jp',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            notifier.onChangedEmail(value);
                            return value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
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
                                onSuccess: () {
                                  IHSUtil.showSnackBar(msg: 'メールを送信しました');
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder<void>(
                                      pageBuilder: (_, __, ___) =>
                                          CodeRemindPage(
                                        email: state.inputData.email,
                                        emailSendMode: EmailSendMode.signUp,
                                      ),
                                    ),
                                  );
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
                            onPressed: () async {
                              // 既存のメールアドレス(oldEmail)でCodeConfirmPageに戻す
                              await Navigator.of(context).pushReplacement(
                                PageRouteBuilder<void>(
                                  pageBuilder: (_, __, ___) => CodeConfirmPage(
                                    email: oldEmail,
                                    emailSendMode: EmailSendMode.signUp,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.sending) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
