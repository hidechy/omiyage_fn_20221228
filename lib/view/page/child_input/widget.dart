import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../extension/date_time.dart';
import '../../../util/util.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/main_layout/widget.dart';
import '../../component/plain_text_field/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import '../root/widget.dart';
import 'notifier.dart';
import 'segment_view/widget.dart';
import 'state.dart';

/// お子さま情報登録画面（新規登録で使用）
class ChildInputPage extends ConsumerStatefulWidget {
  const ChildInputPage({
    super.key,
  });

  @override
  ChildInputPageState createState() => ChildInputPageState();
}

final birthdayControllerProvider =
    AutoDisposeProvider<FormControl<String>>((ref) {
  final _birthday = ref.watch(
      childInputStateProvider.select((value) => value.inputData.birthday));
  return getController(
    type: ValidateTextFieldType.date,
    value: _birthday != null ? _birthday.yyyymmdd : '',
  );
});

class ChildInputPageState extends ConsumerState<ChildInputPage> {
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
    final state = ref.watch(childInputStateProvider);
    final notifier = ref.watch(childInputStateProvider.notifier);

    final form = FormGroup({
      ValidateTextFieldType.date.name: ref.watch(birthdayControllerProvider),
    });

    return MainLayout(
      title: 'お子さま情報',
      showDrawer: false,
      body: Stack(
        children: [
          ReactiveForm(
            formGroup: form,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AbsorbPointer(
                absorbing: state.saving,
                child: Column(
                  children: [
                    // 名前
                    _buildNameField(notifier),
                    const SizedBox(height: 16),
                    // 性別
                    _buildGenderField(context, state, notifier),
                    const SizedBox(height: 16),
                    // 出産予定日
                    _buildScheduledDateField(
                      context,
                      state,
                      notifier,
                      ref.watch(birthdayControllerProvider),
                    ),
                    const SizedBox(height: 32),
                    _buildRegisterArea(state, notifier, form),
                  ],
                ),
              ),
            ),
          ),
          if (state.saving)
            const Positioned(
              child: LoadingIndicator(),
            ),
        ],
      ),
    );
  }

  /// 名前の入力フィールド
  Widget _buildNameField(ChildInputNotifier notifier) {
    return PlainTextField(
      controller: nameController,
      title: '名前（ニックネーム）',
      onChanged: (value) {
        notifier.onChangedNameField(value);
      },
    );
  }

  /// 性別の選択フィールド
  Widget _buildGenderField(
    BuildContext context,
    ChildInputState state,
    ChildInputNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '性別',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        GenderSegmentView(
          selectedType: state.inputData.gender,
          onTap: (gender) {
            notifier.onChangedGender(gender);
          },
        ),
      ],
    );
  }

  /// 出産予定日の入力フィールド
  Widget _buildScheduledDateField(
    BuildContext context,
    ChildInputState state,
    ChildInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.birthday,
      title: '生年月日',
      controller: controller,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  Widget _buildRegisterArea(
    ChildInputState state,
    ChildInputNotifier notifier,
    FormGroup form,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 143,
          child: IHSButton(
            '登録',
            type: IHSButtonType.primary,
            onPressed: () {
              form.markAllAsTouched();
              if (form.valid) {
                notifier.onTapRegister(
                  onSuccess: () {
                    IHSUtil.showSnackBar(msg: 'アカウントを作成しました');
                    // ルートへ
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder<void>(
                        pageBuilder: (_, __, ___) => const RootPage(),
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
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 143,
          child: IHSButton(
            'キャンセル',
            type: IHSButtonType.gray,
            onPressed: () {
              ref.read(childInputStateProvider.notifier).onTapCancel();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
