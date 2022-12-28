import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../type/gender.dart';
import '../../../util/util.dart';
import '../../component/date_pick_text_field/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/plain_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import '../profile_info/state.dart';
import 'notifier.dart';
import 'segment_view/widget.dart';
import 'state.dart';

/// プロフィール情報編集画面
class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({
    super.key,
    required this.inputData,
  });

  final ProfileInfoData inputData;

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late TextEditingController nameContoroller;

  @override
  void initState() {
    nameContoroller = TextEditingController(text: widget.inputData.name);
    super.initState();
  }

  @override
  void dispose() {
    nameContoroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileEditStateProvider(widget.inputData));
    final notifier =
        ref.watch(profileEditStateProvider(widget.inputData).notifier);

    final _postalCodeController = getController(
      type: ValidateTextFieldType.postalCode,
      value: state.inputData?.postalCode ?? '',
    );

    final form = FormGroup({
      ValidateTextFieldType.postalCode.name: _postalCodeController,
    });

    return MainLayout(
      title: 'プロフィール情報',
      showDrawer: false,
      body: ReactiveForm(
        formGroup: form,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AbsorbPointer(
                absorbing: state.saving,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'プロフィール',
                      style: IHSTextStyle.medium.copyWith(
                        color: IHSColors.pink500,
                      ),
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
            if (state.saving) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  /// 名前の入力フィールド
  Widget _buildNameField(ProfileEditNotifier notifier) {
    return PlainTextField(
      controller: nameContoroller,
      title: '名前（ニックネーム）',
      onChanged: (value) {
        notifier.onChangedNameField(value);
      },
    );
  }

  /// 生年月日の入力フィールド
  Widget _buildScheduledDateField(
    BuildContext context,
    ProfileEditState state,
    ProfileEditNotifier notifier,
  ) {
    return DatePickTextField(
      state.inputData?.birthday,
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
    ProfileEditState state,
    ProfileEditNotifier notifier,
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
          selectedType: state.inputData?.gender ?? Gender.man,
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
    ProfileEditState state,
    ProfileEditNotifier notifier,
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
    ProfileEditState state,
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
                widget.inputData.email,
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
    ProfileEditState state,
    ProfileEditNotifier notifier,
    FormGroup form,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IHSButton(
          'プロフィール修正',
          type: IHSButtonType.primary,
          onPressed: () {
            form.markAllAsTouched();

            if (form.valid) {
              notifier.onTapRegister(
                onSuccess: () {
                  IHSUtil.showSnackBar(msg: 'プロフィール情報を更新しました');
                  Navigator.of(context).pop();
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
