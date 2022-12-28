import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../data/model/pregnant_weight_record_list/model.dart';
import '../../../extension/date_time.dart';
import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'state.dart';

/// 妊婦健診入力画面
class PregnantWeightRecordInputPage extends ConsumerStatefulWidget {
  const PregnantWeightRecordInputPage({
    super.key,
    // 健診データ(新規登録ならnull)
    this.record,
  });

  final PregnantWeightRecord? record;

  @override
  PregnantWeightRecordInputPageState createState() =>
      PregnantWeightRecordInputPageState();
}

class PregnantWeightRecordInputPageState
    extends ConsumerState<PregnantWeightRecordInputPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      pregnantWeightGraphInputStateProvider(widget.record),
    );
    final notifier = ref.watch(
      pregnantWeightGraphInputStateProvider(widget.record).notifier,
    );
    final date = state.inputData.date;
    final dateMeasurementController = getController(
      type: ValidateTextFieldType.date,
      value: date != null ? date.yyyymmdd : '',
    );
    final weightController = getController(
      type: ValidateTextFieldType.weight,
      value: state.inputData.weight ?? '',
    );

    final form = FormGroup({
      ValidateTextFieldType.date.name: dateMeasurementController,
      ValidateTextFieldType.weight.name: weightController,
    });

    return GradationLayout(
      title: '体重グラフ',
      showDrawer: false,
      body: Stack(
        children: [
          ReactiveForm(
            formGroup: form,
            child: SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: state.saving,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      '体重入力',
                      style: IHSTextStyle.medium.copyWith(
                        color: IHSColors.pink500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 測定日
                    _buildDateField(
                      context,
                      state,
                      notifier,
                      dateMeasurementController,
                    ),
                    const SizedBox(height: 24),
                    // 体重
                    _buildWeightField(
                      context,
                      state,
                      notifier,
                      weightController,
                    ),
                    const SizedBox(height: 32),
                    if (widget.record == null) ...[
                      Center(
                        child: SizedBox(
                          width: 128,
                          child: IHSButton(
                            '登録',
                            type: IHSButtonType.primary,
                            onPressed: () {
                              form.markAllAsTouched();
                              if (!form.valid) {
                                return;
                              }

                              _onTapRegister(state, notifier);
                            },
                          ),
                        ),
                      )
                    ],
                    if (widget.record != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 128,
                            child: IHSButton(
                              '削除',
                              type: IHSButtonType.gray,
                              onPressed: () {
                                _onTapDelete(state, notifier);
                              },
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: 128,
                            child: IHSButton(
                              '修正',
                              type: IHSButtonType.primary,
                              onPressed: () {
                                form.markAllAsTouched();
                                if (!form.valid) {
                                  return;
                                }

                                _onTapRegister(state, notifier);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          if (state.saving)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  // 測定日の入力フィールド
  Widget _buildDateField(
    BuildContext context,
    PregnantWeightRecordInputState state,
    PregnantWeightRecordInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.date,
      title: '測定日',
      isRequired: true,
      controller: controller,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: (value) {
        notifier.onChangedDateField(value);
      },
    );
  }

  /// 体重の入力フィールド
  Widget _buildWeightField(
    BuildContext context,
    PregnantWeightRecordInputState state,
    PregnantWeightRecordInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ValidateTextField(
          title: '体重',
          isRequired: true,
          width: 112,
          type: ValidateTextFieldType.weight,
          hintText: '--.-',
          controller: controller,
          keyboardType: TextInputType.datetime,
          onChanged: (value) {
            notifier.onChangedWeightField(value);
          },
        ),
        const SizedBox(width: 8),
        Text('kg', style: IHSTextStyle.small),
      ],
    );
  }

  void _onTapDelete(
    PregnantWeightRecordInputState state,
    PregnantWeightRecordInputNotifier notifier,
  ) {
    final dateStr = state.inputData.date!.yyyymmdd;
    IHSDialog(
      context: context,
      title: '$dateStrの記録を削除します。\nよろしいですか？',
      okStr: '削除する',
      okButtonType: IHSButtonType.gray,
      cancelStr: 'キャンセル',
      cancelButtonType: IHSButtonType.primary,
      onTap: (_) {
        notifier.onTapDelete(
          recordId: widget.record!.recordId,
          onSuccess: () {
            IHSUtil.showSnackBar(msg: 'データを削除しました');
            Navigator.of(context).pop();
          },
          onFailure: (msg) {
            IHSUtil.showSnackBar(msg: msg);
          },
        );
      },
    ).showAlert();
  }

  void _onTapRegister(
    PregnantWeightRecordInputState state,
    PregnantWeightRecordInputNotifier notifier,
  ) {
    notifier.onTapRegister(
      recordId: widget.record?.recordId,
      onSuccess: () {
        IHSUtil.showSnackBar(
          msg: widget.record == null ? 'データを登録しました' : 'データを更新しました',
        );
        Navigator.of(context).pop();
      },
      onFailure: (msg) {
        IHSUtil.showSnackBar(msg: msg);
      },
    );
  }
}
