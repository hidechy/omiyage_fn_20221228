import 'package:family_notes/view/page/password_reset_completed/widget.dart';
import 'package:family_notes/view/page/root/widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../util/util.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/ihs_text_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/text_style.dart';
import '../undeliverd_email/widget.dart';
import 'notifier.dart';

/// パスワード再設定 - 認証コード入力画面
class PasswordResetCodeInputPage extends ConsumerWidget {
  PasswordResetCodeInputPage({
    required this.email,
    super.key,
  });

  final String email;

  final _authCodeController = getController(
    type: ValidateTextFieldType.authCode,
    value: '',
  );
  final _passwordController = getController(
    type: ValidateTextFieldType.password,
    value: '',
  );
  final _passwordConfirmController = getController(
    type: ValidateTextFieldType.passwordConfirmation,
    value: '',
  );

  FormGroup get form => FormGroup(
        {
          ValidateTextFieldType.email.name: _authCodeController,
          ValidateTextFieldType.password.name: _passwordController,
          ValidateTextFieldType.passwordConfirmation.name:
              _passwordConfirmController,
        },
        validators: [
          Validators.mustMatch(
            ValidateTextFieldType.password.name,
            ValidateTextFieldType.passwordConfirmation.name,
            markAsDirty: false,
          )
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordResetCodeConfirmStateProvider);
    final notifier = ref.watch(passwordResetCodeConfirmStateProvider.notifier);
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
                    const SizedBox(height: 48),
                    Text(
                      'パスワード再設定',
                      style: IHSTextStyle.medium,
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
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'パスワード',
                          style: IHSTextStyle.xSmall,
                        ),
                        const SizedBox(height: 8),
                        ValidateTextField(
                          key: const Key('PasswordTextField'),
                          type: ValidateTextFieldType.password,
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            notifier.onChangedPassword(value.trim());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'パスワード（確認用）',
                          style: IHSTextStyle.xSmall,
                        ),
                        const SizedBox(height: 8),
                        ValidateTextField(
                          key: const Key('PasswordTextField_Confirm'),
                          type: ValidateTextFieldType.passwordConfirmation,
                          controller: _passwordConfirmController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            notifier.onChangedConfirmPassword(value.trim());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '８桁以上\n英大文字、英小文字、数字、\n記号(-*/+.~!@#\$%^&*())\nのうち最低２種類を使用',
                      style: IHSTextStyle.small,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 144,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IHSButton(
                            '完了',
                            type: IHSButtonType.primary,
                            onPressed: () {
                              form.markAllAsTouched();
                              if (!form.valid) {
                                return;
                              }
                              notifier.onTappedSend(
                                email: email,
                                onSuccess: () {
                                  // パスワード変更完了画面
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder<void>(
                                      pageBuilder: (_, __, ___) =>
                                          const PasswordResetCompletedPage(),
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
                              _onTapCancel(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    IHSTextButton(
                      'メールを再送信する',
                      onPressed: () {
                        notifier.onTappedCodeResend(
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
                    const SizedBox(height: 40),
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

  void _onTapCancel(BuildContext context) {
    // トップに戻る
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const RootPage(),
      ),
    );
  }
}
