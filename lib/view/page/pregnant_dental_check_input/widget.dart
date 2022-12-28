import 'package:family_notes/view/component/multiline_text_field/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import '../pregnant_dental_check_select/type.dart';
import 'notifier.dart';
import 'select_list_view/widget.dart';
import 'state.dart';

/// 妊婦歯科健診入力画面
class PregnantDentalCheckInputPage extends ConsumerWidget {
  const PregnantDentalCheckInputPage({
    super.key,
    required this.inputType,
  });

  final PregnantDentalCheckInputType inputType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pregnantDentalCheckInputProvider(inputType));
    final notifier =
        ref.read(pregnantDentalCheckInputProvider(inputType).notifier);

    return GradationLayout(
      title: '歯科健診入力',
      showDrawer: false,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (loadedState) {
          final isInputTypeNew = inputType is PregnantDentalCheckInputNew;
          final _dateController = loadedState.dateController!;
          final _weekController = loadedState.weekController!;
          final memoController = loadedState.inputData.memoController!;
          final form = FormGroup({
            ValidateTextFieldType.date.name: _dateController,
            ValidateTextFieldType.int.name: _weekController,
          });

          return ReactiveForm(
            formGroup: form,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        '健診入力',
                        style: IHSTextStyle.medium.copyWith(
                          color: IHSColors.pink500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 健診日
                      _buildDateField(
                        context,
                        loadedState,
                        notifier,
                        _dateController,
                      ),
                      const SizedBox(height: 24),
                      // 妊娠週数
                      _buildWeekRow(
                        context,
                        loadedState,
                        notifier,
                        _weekController,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '健診結果',
                        style: IHSTextStyle.small,
                      ),
                      const SizedBox(height: 8),
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: IHSColors.white,
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: IHSColors.black800,
                            ),
                          ),
                        ),
                        child: SelectListView(
                          selectedType: loadedState.inputData.type,
                          onTap: (type, _) {
                            notifier.onChangedSelectedItem(type);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // メモ
                      _buildMemoField(notifier, memoController),
                      const SizedBox(height: 32),
                      isInputTypeNew
                          ? _RegisterButtonArea(form: form, notifier: notifier)
                          : _EditButtonArea(form: form, notifier: notifier),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 健診日の入力フィールド
  Widget _buildDateField(
    BuildContext context,
    PregnantDentalCheckInputLoaded state,
    PregnantDentalCheckInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.date,
      controller: controller,
      title: '健診日',
      isRequired: true,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  /// 妊娠週数の入力フィールド
  Widget _buildWeekRow(
    BuildContext context,
    PregnantDentalCheckInputLoaded state,
    PregnantDentalCheckInputNotifier notifier,
    FormControl<String> controller,
  ) {
    Color _pregnantWeekColor() {
      return state.inputData.isAfterBirth
          ? IHSColors.black400
          : IHSColors.black800;
    }

    Color _afterBornColor() {
      final _week = state.inputData.week;
      return (_week == null || _week == '')
          ? IHSColors.black800
          : IHSColors.black400;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            '妊娠週数',
            style: IHSTextStyle.small.copyWith(color: _pregnantWeekColor()),
          ),
        ),
        const SizedBox(width: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValidateTextField(
              width: 72,
              type: ValidateTextFieldType.int,
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: TextInputType.datetime,
              borderColor: _pregnantWeekColor(),
              onChanged: (value) {
                notifier
                  ..onChangedWeekField(value)
                  ..onChangedPostpartem(isAfterBirth: false);
              },
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('週数',
                  style: IHSTextStyle.small.copyWith(
                    color: _pregnantWeekColor(),
                  )),
            ),
          ],
        ),
        const SizedBox(width: 24),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            final _isAfterBoon = state.inputData.isAfterBirth;
            notifier.onChangedPostpartem(isAfterBirth: !_isAfterBoon);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Text(
                  '産後',
                  style: IHSTextStyle.small.copyWith(
                    color: _afterBornColor(),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    activeColor: state.inputData.isAfterBirth
                        ? IHSColors.black800
                        : IHSColors.black400,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    autofocus: true,
                    value: state.inputData.isAfterBirth,
                    onChanged: (value) {
                      notifier
                        ..onChangedPostpartem(
                          isAfterBirth: value ?? false,
                        )
                        ..onChangedWeekField('');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// メモの入力フィールド
  Widget _buildMemoField(
    PregnantDentalCheckInputNotifier notifier,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メモ、または処置などについて',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: controller,
          hintText: '自由に入力してください',
          minLines: 4,
          onChanged: notifier.onChangedMemoField,
        ),
      ],
    );
  }
}

class _RegisterButtonArea extends StatelessWidget {
  const _RegisterButtonArea({
    required this.form,
    required this.notifier,
  });

  final FormGroup form;
  final PregnantDentalCheckInputNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 128,
        child: IHSButton(
          '登録',
          type: IHSButtonType.primary,
          onPressed: () async {
            form.markAllAsTouched();
            if (!form.valid) {
              return;
            }

            // ローディングダイアログ表示
            IHSUtil.showLoadingDialog(context);
            await notifier.onTapSave(
              onSuccess: () {
                IHSUtil.showSnackBar(msg: 'データを登録しました');
                Navigator.of(context).pop();
              },
              onFailure: (msg) {
                IHSUtil.showSnackBar(msg: msg);
              },
            );
            // ローディングダイアログ閉じる
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class _EditButtonArea extends StatelessWidget {
  const _EditButtonArea({
    required this.form,
    required this.notifier,
  });

  final FormGroup form;
  final PregnantDentalCheckInputNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        Expanded(
          child: IHSButton(
            '削除',
            type: IHSButtonType.gray,
            onPressed: () async {
              IHSUtil.showLoadingDialog(context);
              await notifier.onTapDelete(
                onSuccess: () {
                  IHSUtil.showSnackBar(msg: 'データを削除しました');
                  Navigator.of(context).pop();
                },
                onFailure: (msg) {
                  IHSUtil.showSnackBar(msg: msg);
                },
              );
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: IHSButton(
            '修正',
            type: IHSButtonType.primary,
            onPressed: () async {
              form.markAllAsTouched();
              if (!form.valid) {
                return;
              }

              IHSUtil.showLoadingDialog(context);
              await notifier.onTapSave(
                onSuccess: () {
                  IHSUtil.showSnackBar(msg: 'データを更新しました');
                  Navigator.of(context).pop();
                },
                onFailure: (msg) {
                  IHSUtil.showSnackBar(msg: msg);
                },
              );
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
