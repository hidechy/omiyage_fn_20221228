import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/component/main_layout/widget.dart';
import '/view/component/validate_text_field/type.dart';
import '/view/page/code_remind/type.dart';
import '/view/page/email_reset/notifier.dart';
import '/view/style/text_style.dart';
import '../../../util/util.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/validate_text_field/widget.dart';
import '../code_remind/widget.dart';

/// メールリセット画面
/// - 設定→プロフィール情報→メールアドレス変更より遷移
class EmailResetPage extends ConsumerWidget {
  EmailResetPage({super.key});

  final _emailController = getController(
    type: ValidateTextFieldType.email,
    value: '',
  );

  FormGroup get form => FormGroup(
        {
          ValidateTextFieldType.email.name: _emailController,
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(emailResetStateProvider);
    final notifier = ref.watch(emailResetStateProvider.notifier);
    return MainLayout(
      showAppBar: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: state.saving,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'メールアドレスを変更します',
                    style: IHSTextStyle.medium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '新しいメールアドレスを入力してください',
                    style: IHSTextStyle.small,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '新しいメールアドレス',
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
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 143,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        IHSButton(
                          '登録',
                          type: IHSButtonType.primary,
                          onPressed: () {
                            form.markAllAsTouched();
                            if (!form.valid) {
                              return;
                            }
                            notifier.onTapRegister(
                              onSuccess: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder<void>(
                                    pageBuilder: (_, __, ___) => CodeRemindPage(
                                      email: state.email,
                                      emailSendMode: EmailSendMode.resetEmail,
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.saving) const LoadingIndicator(),
        ],
      ),
    );
  }
}
