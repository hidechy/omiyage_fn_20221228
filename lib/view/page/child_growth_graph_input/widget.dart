import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../data/model/child_growth_record_list/model.dart';
import '../../../extension/date_time.dart';
import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_dialog/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/validate_date_pick_text_field/widget.dart';
import '../../component/validate_text_field/type.dart';
import '../../component/validate_text_field/validation.dart';
import '../../component/validate_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'state.dart';
import 'weight_segment_view/widget.dart';

/// 身体発育曲線入力画面
class ChildGrowthGraphInputPage extends ConsumerStatefulWidget {
  const ChildGrowthGraphInputPage({
    super.key,
    // 入力データ(新規登録ならnull)
    this.record,
  });

  final ChildGrowthRecord? record;

  @override
  ChildGrowthGraphInputPageState createState() =>
      ChildGrowthGraphInputPageState();
}

class ChildGrowthGraphInputPageState
    extends ConsumerState<ChildGrowthGraphInputPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(childWeightGraphInputStateProvider(widget.record));
    final notifier = ref.watch(
      childWeightGraphInputStateProvider(widget.record).notifier,
    );
    final inputData = state.inputData;
    final date = inputData.date;
    final dateMeasurementController = getController(
      type: ValidateTextFieldType.date,
      value: date != null ? date.yyyymmdd : '',
    );
    final heightController = getController(
      type: ValidateTextFieldType.height,
      value: inputData.height ?? '',
      validator: NumValidationType.height.numValid,
    );
    final headController = getController(
      type: ValidateTextFieldType.head,
      value: inputData.head ?? '',
      validator: NumValidationType.head.numValid,
    );
    final chestController = getController(
      type: ValidateTextFieldType.chest,
      value: inputData.chest ?? '',
      validator: NumValidationType.chest.numValid,
    );
    final gramsController = getController(
      type: ValidateTextFieldType.childGramsWeight,
      value: inputData.grams ?? '',
      validator: NumValidationType.grams.gramsValid,
    );
    final kilogramsController = getController(
      type: ValidateTextFieldType.childKilogramsWeight,
      value: inputData.kilograms ?? '',
      validator: NumValidationType.kilograms.numValid,
    );

    /// 子どもの体重種類事に適用させるバリデーション
    final validateWeightTypeName = WeightType.g == inputData.weightType
        ? ValidateTextFieldType.childGramsWeight.name
        : ValidateTextFieldType.childKilogramsWeight.name;

    /// 子どもの体重種類事に保持させる体重入力コントローラー
    final weightController = WeightType.g == inputData.weightType
        ? gramsController
        : kilogramsController;

    final form = FormGroup({
      ValidateTextFieldType.date.name: dateMeasurementController,
      ValidateTextFieldType.height.name: heightController,
      ValidateTextFieldType.head.name: headController,
      ValidateTextFieldType.chest.name: chestController,
      validateWeightTypeName: weightController,
    });

    return GradationLayout(
      title: '身体発育曲線',
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
                      '発育入力',
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
                    // 身長
                    _buildHeightField(
                        context, state, notifier, heightController),
                    const SizedBox(height: 32),
                    // 体重
                    _buildWeightField(
                      state,
                      notifier,
                      gramsController,
                      kilogramsController,
                    ),
                    const SizedBox(height: 24),
                    // 頭囲
                    _buildHeadField(context, state, notifier, headController),
                    const SizedBox(height: 24),
                    // 胸囲
                    _buildChestField(context, state, notifier, chestController),
                    const SizedBox(height: 32),
                    _buildRegisterArea(state, notifier, form),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          if (state.saving) const LoadingIndicator(),
        ],
      ),
    );
  }

  // 測定日の入力フィールド
  Widget _buildDateField(
    BuildContext context,
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateDatePickTextField(
      state.inputData.date,
      title: '測定日',
      isRequired: true,
      controller: controller,
      firstDate: IHSConstants.datePickerFirstDateYearNum,
      lastDate: IHSConstants.datePickerLastDateYearNum,
      onChanged: notifier.onChangedDateField,
    );
  }

  /// 身長の入力フィールド
  Widget _buildHeightField(
    BuildContext context,
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateTextField(
      title: '身長（cm）',
      type: ValidateTextFieldType.height,
      controller: controller,
      onChanged: (control) {
        notifier.onChangedHeightField(control);
      },
    );
  }

  /// 体重の入力フィールド
  Widget _buildWeightField(
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormControl<String> gramscontroller,
    FormControl<String> kilogramscontroller,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // kgとgで動的にバリデーションtypeを切り替えるとエラーメッセージが表示されないので、
        // kgとgで別々のTextFiledとして表示させている
        // 体重(kg)入力用
        Visibility(
          visible: WeightType.kg == state.inputData.weightType,
          child: Expanded(
            child: ValidateTextField(
              title: '体重',
              type: ValidateTextFieldType.childKilogramsWeight,
              controller: kilogramscontroller,
              hintText: '--.-',
              onChanged: (control) {
                notifier.onChangedKilogramsField(control);
              },
            ),
          ),
        ),
        // 体重(g)入力用
        Visibility(
          visible: WeightType.g == state.inputData.weightType,
          child: Expanded(
            child: ValidateTextField(
              title: '体重',
              type: ValidateTextFieldType.childGramsWeight,
              controller: gramscontroller,
              hintText: '--.-',
              onChanged: (control) {
                notifier.onChangedGramsField(control);
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: WeightSegmentView(
            selectedType: state.inputData.weightType,
            onTap: (weightType) {
              notifier.onChangedWeightType(weightType);
              if (WeightType.g == weightType) {
                notifier.weightConvertFromKilogramsToGrams();
              } else {
                notifier.weightConvertFromGramsToKilograms();
              }
            },
          ),
        ),
      ],
    );
  }

  /// 頭囲の入力フィールド
  Widget _buildHeadField(
    BuildContext context,
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateTextField(
      title: '頭囲（cm）',
      type: ValidateTextFieldType.head,
      controller: controller,
      onChanged: (control) {
        notifier.onChangedHeadField(control);
      },
    );
  }

  /// 胸囲の入力フィールド
  Widget _buildChestField(
    BuildContext context,
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormControl<String> controller,
  ) {
    return ValidateTextField(
      title: '胸囲（cm）',
      type: ValidateTextFieldType.chest,
      controller: controller,
      onChanged: (control) {
        notifier.onChangedChestField(control);
      },
    );
  }

  Widget _buildRegisterArea(
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
    FormGroup form,
  ) {
    if (widget.record == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
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
        ],
      );
    } else {
      return Row(
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
      );
    }
  }

  void _onTapRegister(
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
  ) {
    // 選択済み体重種類がgでなくkgの場合は、
    // apiにグラム値で渡すため表示されているキログラム値をグラム値に変換している
    if (WeightType.kg == state.inputData.weightType) {
      notifier.weightConvertFromKilogramsToGrams();
    }

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

  void _onTapDelete(
    ChildGrowthGraphInputState state,
    ChildGrowthGraphInputNotifier notifier,
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
}
