import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../data/model/checkup_list/model.dart';
import '../../../extension/date_time.dart';
import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/multiline_text_field/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/validation.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'select_list_view/widget.dart';
import 'state.dart';

/// 妊婦健診入力画面
class PregnantHealthCheckInputPage extends ConsumerWidget {
  const PregnantHealthCheckInputPage({
    super.key,
    // 健診データ(新規登録ならnull)
    this.checkupModel,
  });

  final CheckupModel? checkupModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(pregnantHealthCheckInputStateProvider(checkupModel));
    final notifier =
        ref.watch(pregnantHealthCheckInputStateProvider(checkupModel).notifier);

    return GradationLayout(
      title: '妊婦健診入力',
      showDrawer: false,
      body: state.map(
        init: (_) => const LoadingIndicator(),
        loading: (_) => const LoadingIndicator(),
        loaded: (value) {
          final _state = value.data;
          final inputData = _state.inputData;
          final memoController =
              inputData.memoController ?? TextEditingController(text: '');
          final _date = inputData.date;

          final dateController = getController(
            type: ValidateTextFieldType.date,
            value: _date != null ? _date.yyyymmdd : '',
          );
          final weekController = getController(
            type: ValidateTextFieldType.int,
            isRequired: false,
            value: inputData.week,
            validator: NumValidationType.week.numValid,
          );
          final dayController = getController(
            type: ValidateTextFieldType.int,
            isRequired: false,
            value: inputData.day,
            validator: NumValidationType.day.numValid,
          );
          final weightController = getController(
            type: ValidateTextFieldType.double,
            isRequired: false,
            value: inputData.weight,
          );

          final form = FormGroup({
            ValidateTextFieldType.date.name: dateController,
            ValidateTextFieldType.int.name: weekController,
            ValidateTextFieldType.int.name: dayController,
            ValidateTextFieldType.double.name: weightController,
          });

          return Stack(
            children: [
              ReactiveForm(
                formGroup: form,
                child: SingleChildScrollView(
                  child: AbsorbPointer(
                    absorbing: value.data.loading,
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
                          _state,
                          notifier,
                          dateController,
                        ),
                        const SizedBox(height: 24),
                        // 妊娠週数
                        _buildWeekRow(
                          notifier,
                          weekController,
                          dayController,
                        ),
                        const SizedBox(height: 24),
                        // 体重
                        _buildWeightField(
                          notifier,
                          weightController,
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
                            map: inputData.selectedItem,
                            onTap: (type, value) {
                              notifier.onChangedSelectedItem(
                                type,
                                value: value,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        // メモ
                        _buildMemoField(
                          notifier,
                          memoController,
                        ),
                        const SizedBox(height: 32),
                        checkupModel == null
                            ? _buildNewRegisterButton(
                                context,
                                form,
                                notifier,
                              )
                            : _buildUpdateButtons(
                                context,
                                form,
                                _state,
                                notifier,
                              ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
              if (_state.loading) const LoadingIndicator(),
            ],
          );
        },
      ),
    );
  }

  // 新規登録ボタン
  Widget _buildNewRegisterButton(
    BuildContext context,
    FormGroup form,
    PregnantHealthCheckInputNotifier notifier,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 128,
          child: IHSButton(
            '登録',
            type: IHSButtonType.primary,
            onPressed: () {
              _onTapSave(context, form, notifier);
            },
          ),
        ),
      ],
    );
  }

  // 削除/更新ボタン
  Widget _buildUpdateButtons(
    BuildContext context,
    FormGroup form,
    PregnantHealthCheckInputState state,
    PregnantHealthCheckInputNotifier notifier,
  ) {
    return Row(
      children: [
        const SizedBox(width: 24),
        Expanded(
          child: IHSButton(
            '削除',
            type: IHSButtonType.gray,
            onPressed: () {
              _onTapDelete(context, form, state, notifier);
            },
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: IHSButton(
            '修正',
            type: IHSButtonType.primary,
            onPressed: () {
              _onTapSave(context, form, notifier);
            },
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  // 登録or更新ボタン押下
  void _onTapSave(
    BuildContext context,
    FormGroup form,
    PregnantHealthCheckInputNotifier notifier,
  ) {
    form.markAllAsTouched();
    if (form.valid) {
      notifier.onTapRegister(
        checkupId: checkupModel?.checkupId,
        onSuccess: () {
          IHSUtil.showSnackBar(
            msg: checkupModel == null ? '健診結果を登録しました' : '健診結果を更新しました',
          );
          Navigator.of(context).pop();
        },
        onFailure: (msg) {
          IHSUtil.showSnackBar(msg: msg);
        },
      );
    }
  }

  // 削除ボタン押下
  void _onTapDelete(
    BuildContext context,
    FormGroup form,
    PregnantHealthCheckInputState state,
    PregnantHealthCheckInputNotifier notifier,
  ) {
    form.markAllAsTouched();
    if (!form.valid) {
      return;
    }
    final dateStr = state.inputData.date!.yyyymmdd;
    IHSDialog(
      context: context,
      title: '$dateStrの健診記録を\n削除します。\nよろしいですか？',
      okStr: '削除する',
      okButtonType: IHSButtonType.gray,
      cancelStr: 'キャンセル',
      cancelButtonType: IHSButtonType.primary,
      onTap: (_) {
        notifier.onTapDelete(
          checkupId: checkupModel?.checkupId,
          onSuccess: () {
            IHSUtil.showSnackBar(msg: '検診結果を削除しました');
            Navigator.of(context).pop();
          },
          onFailure: (msg) {
            IHSUtil.showSnackBar(msg: msg);
          },
        );
      },
    ).showAlert();
  }

  // 健診日の入力フィールド
  Widget _buildDateField(
    BuildContext context,
    PregnantHealthCheckInputState state,
    PregnantHealthCheckInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.date,
      title: '健診日',
      isRequired: true,
      controller: controller,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  /// 妊娠週数の入力フィールド
  Widget _buildWeekRow(
    PregnantHealthCheckInputNotifier notifier,
    FormControl<String> weekController,
    FormControl<String> dayController,
  ) {
    return Row(
      children: [
        Text(
          '妊娠週数',
          style: IHSTextStyle.small,
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValidateTextField(
                    width: 72,
                    type: ValidateTextFieldType.int,
                    textAlign: TextAlign.center,
                    controller: weekController,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {
                      notifier.onChangedWeekField(value);
                    },
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Text('週数', style: IHSTextStyle.small),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValidateTextField(
                    width: 72,
                    type: ValidateTextFieldType.int,
                    textAlign: TextAlign.center,
                    controller: dayController,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) => notifier.onChangedDayField(value),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Text('日', style: IHSTextStyle.small),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 体重の入力フィールド
  Widget _buildWeightField(
    PregnantHealthCheckInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidateTextField(
          title: '体重',
          hintText: '--.-',
          textAlign: TextAlign.center,
          type: ValidateTextFieldType.double,
          width: 112,
          controller: controller,
          keyboardType: TextInputType.datetime,
          onChanged: (value) => notifier.onChangedWeightField(value),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text('kg', style: IHSTextStyle.small),
        ),
      ],
    );
  }

  // メモの入力フィールド
  Widget _buildMemoField(
    PregnantHealthCheckInputNotifier notifier,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メモ、その他の疾患について',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: controller,
          hintText: '自由に入力してください',
          minLines: 4,
          onChanged: (value) {
            notifier.onChangedMemoField(value);
          },
        ),
      ],
    );
  }
}
