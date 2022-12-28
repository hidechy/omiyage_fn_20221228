import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../util/util.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/validate_text_field/custom_validation.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/text_style.dart';
import '../setting_password_reset_complete/widget.dart';
import 'notifier.dart';

/// パスワード変更画面
/// - 設定画面から実施する方
class SettingPasswordResetInputPage extends ConsumerWidget {
  const SettingPasswordResetInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingPasswordResetStateProvider);
    final notifier = ref.watch(settingPasswordResetStateProvider.notifier);
    final _oldPasswordController = getController(
      type: ValidateTextFieldType.password,
      value: state.inputData.oldPassword,
    );
    final _passwordController = getController(
      type: ValidateTextFieldType.newPassword,
      value: state.inputData.password,
    );
    final _passwordConfirmController = getController(
      type: ValidateTextFieldType.passwordConfirmation,
      value: state.inputData.confirmPassword,
    );
    final form = FormGroup(
      {
        ValidateTextFieldType.password.name: _oldPasswordController,
        ValidateTextFieldType.newPassword.name: _passwordController,
        ValidateTextFieldType.passwordConfirmation.name:
            _passwordConfirmController,
      },
      validators: [
        CustomValidators.mustNotMatch(
          ValidateTextFieldType.password.name,
          ValidateTextFieldType.newPassword.name,
          markAsDirty: false,
        ),
        Validators.mustMatch(
          ValidateTextFieldType.newPassword.name,
          ValidateTextFieldType.passwordConfirmation.name,
          markAsDirty: false,
        )
      ],
    );

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
                          '現在のパスワード',
                          style: IHSTextStyle.xSmall,
                        ),
                        const SizedBox(height: 8),
                        ValidateTextField(
                          type: ValidateTextFieldType.password,
                          controller: _oldPasswordController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: notifier.onChangedOldPassword,
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
                          type: ValidateTextFieldType.newPassword,
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: notifier.onChangedPassword,
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
                          type: ValidateTextFieldType.passwordConfirmation,
                          controller: _passwordConfirmController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: notifier.onChangedConfirmPassword,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '８桁以上\n英大文字、英小文字、数字、記号\nのうち最低２種類を使用',
                      style: IHSTextStyle.small,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 143,
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
                              notifier.onTapRegister(
                                onSuccess: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder<void>(
                                      pageBuilder: (_, __, ___) =>
                                          const SettingPasswordResetCompletedPage(),
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
}
