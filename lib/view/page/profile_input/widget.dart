import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../util/util.dart';
import '../../component/date_pick_text_field/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/plain_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import '../profile_input_completed/widget.dart';
import 'notifier.dart';
import 'segment_view/widget.dart';
import 'state.dart';

/// プロフィール情報登録画面（新規登録時に使用）
class ProfileInputPage extends ConsumerStatefulWidget {
  const ProfileInputPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ProfileInputPageState createState() => ProfileInputPageState();
}

class ProfileInputPageState extends ConsumerState<ProfileInputPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileInputStateProvider);
    final notifier = ref.watch(profileInputStateProvider.notifier);
    final _postalCodeController = getController(
      type: ValidateTextFieldType.postalCode,
      value: state.inputData.postalCode,
    );
    final form = FormGroup({
      ValidateTextFieldType.postalCode.name: _postalCodeController,
    });

    return MainLayout(
      title: 'プロフィール情報',
      showDrawer: false,
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '※プロフィール情報はあとから変更できます。',
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 24),
              // 名前
              _buildNameField(notifier),
              const SizedBox(height: 24),
              // 生年月日
              _buildScheduledDateField(context, state, notifier),
              const SizedBox(height: 24),
              // 性別
              _buildGenderField(context, state, notifier),
              const SizedBox(height: 24),
              // 郵便番号
              _buildPostalCodeField(
                context,
                state,
                notifier,
                _postalCodeController,
              ),
              const SizedBox(height: 24),
              // メールアドレス
              _buildEmailItem(state),
              const SizedBox(height: 32),
              _buildRegisterArea(state, notifier, form),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// 名前の入力フィールド
  Widget _buildNameField(ProfileInputNotifier notifier) {
    return PlainTextField(
      controller: nameController,
      title: '名前（ニックネーム）',
      onChanged: (value) {
        notifier.onChangedNameField(value);
      },
    );
  }

  /// 生年月日の入力フィールド
  Widget _buildScheduledDateField(
    BuildContext context,
    ProfileInputState state,
    ProfileInputNotifier notifier,
  ) {
    return DatePickTextField(
      state.inputData.birthday,
      title: '生年月日',
      onChanged: (date) {
        notifier.onChangedDateField(date);
      },
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
    );
  }

  /// 性別の選択フィールド
  Widget _buildGenderField(
    BuildContext context,
    ProfileInputState state,
    ProfileInputNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '性別',
          style: IHSTextStyle.small.copyWith(
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        ProfileGenderSegmentView(
          selectedType: state.inputData.gender,
          onTap: (value) {
            notifier.onChangedGenderField(value);
          },
        ),
      ],
    );
  }

  /// 郵便番号の入力フィールド
  Widget _buildPostalCodeField(
    BuildContext context,
    ProfileInputState state,
    ProfileInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateTextField(
      title: '郵便番号',
      width: 168,
      isRequired: true,
      type: ValidateTextFieldType.postalCode,
      hintText: '1234567',
      controller: controller,
      keyboardType: TextInputType.datetime,
      onChanged: (control) {
        notifier.onChangedPostalCodeField(control);
      },
    );
  }

  /// メールアドレス表示
  Widget _buildEmailItem(
    ProfileInputState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メールアドレス',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                widget.email,
                overflow: TextOverflow.ellipsis,
                style: IHSTextStyle.small,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterArea(
    ProfileInputState state,
    ProfileInputNotifier notifier,
    FormGroup form,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IHSButton(
          'プロフィール登録',
          type: IHSButtonType.primary,
          onPressed: () {
            form.markAllAsTouched();

            if (form.valid) {
              notifier.onTapRegister(
                onSuccess: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder<void>(
                      pageBuilder: (_, __, ___) =>
                          const ProfileInputCompletedPage(),
                    ),
                  );
                },
                onFailure: (msg) {
                  IHSUtil.showSnackBar(msg: msg);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
