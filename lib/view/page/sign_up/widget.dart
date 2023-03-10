import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../util/util.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_text_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../code_remind/type.dart';
import '../code_remind/widget.dart';
import '../root/widget.dart';
import 'agreement_area/widget.dart';
import 'notifier.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});

  final _emailController = getController(
    type: ValidateTextFieldType.email,
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
          ValidateTextFieldType.email.name: _emailController,
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
    final state = ref.watch(signUpInputStateProvider);
    final notifier = ref.watch(signUpInputStateProvider.notifier);
    return MainLayout(
      showAppBar: false,
      body: ReactiveForm(
        formGroup: form,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: state.fetching || state.saving,
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    Text(
                      '????????????',
                      style: IHSTextStyle.medium,
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AgreementArea(),
                        const SizedBox(height: 24),
                        Text(
                          '?????????????????????',
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
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '???????????????',
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
                          '??????????????????????????????',
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
                        const SizedBox(height: 16),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('8?????????'),
                              Text('?????????????????????????????????????????????'),
                              Text('???????????????2??????????????????'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 144,
                      child: IHSButton(
                        '????????????',
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
                    ),
                    const SizedBox(height: 32),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '?????????????????????????????????????????????',
                          style: IHSTextStyle.small.copyWith(
                            color: IHSColors.pink500,
                          ),
                        ),
                        IHSTextButton(
                          '?????????',
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder<void>(
                                pageBuilder: (_, __, ___) => const RootPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            if (state.fetching || state.saving) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
