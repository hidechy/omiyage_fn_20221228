import 'package:family_notes/view/page/child_health_check_input/type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../component/validate_text_field/type.dart';
import '../../../component/validate_text_field/widget.dart';
import '../../../style/text_style.dart';
import '../notifier.dart';
import '../state.dart';

enum BodyInfoInputType {
  /// 身長
  height(label: '身長', unit: 'cm'),

  /// 体重
  gWeight(label: '体重', unit: 'g'),

  /// 体重
  kgWeight(label: '体重', unit: 'kg'),

  /// 頭囲
  head(label: '頭囲', unit: 'cm'),

  /// 胸囲
  chest(label: '胸囲', unit: 'cm');

  const BodyInfoInputType({
    required this.label,
    required this.unit,
  });

  final String label;
  final String unit;
}

class BodyInfoInput extends ConsumerWidget {
  const BodyInfoInput({
    super.key,
    this.hightController,
    this.weightController,
    this.headController,
    this.chestController,
  });

  final FormControl<String>? hightController;
  final FormControl<String>? weightController;
  final FormControl<String>? headController;
  final FormControl<String>? chestController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(childHealthCheckInputProvider.notifier);

    final state =
        ref.watch(childHealthCheckInputProvider) as ChildHealthCheckInputLoaded;
    final weightUnitType =
        WeightUnitType.getUnitType(type: state.inputData.selectedType!);
    final isUnitGram = weightUnitType == WeightUnitType.gram;

    return Column(
      children: [
        if (hightController != null && weightController != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hightController != null) ...[
                InputField(
                  title: BodyInfoInputType.height.label,
                  unit: BodyInfoInputType.height.unit,
                  controller: hightController!,
                  onChanged: notifier.onChangedHeight,
                ),
                const SizedBox(width: 16),
              ],
              if (weightController != null)
                InputField(
                  title: isUnitGram
                      ? BodyInfoInputType.gWeight.label
                      : BodyInfoInputType.kgWeight.label,
                  unit: isUnitGram
                      ? BodyInfoInputType.gWeight.unit
                      : BodyInfoInputType.kgWeight.unit,
                  hintText: isUnitGram ? '----' : '--.-',
                  controller: weightController!,
                  onChanged: notifier.onChangedWeight,
                ),
            ],
          ),
        const SizedBox(height: 24),
        if (headController != null && chestController != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (headController != null) ...[
                InputField(
                  title: BodyInfoInputType.head.label,
                  unit: BodyInfoInputType.head.unit,
                  controller: headController!,
                  onChanged: notifier.onChangedHead,
                ),
                const SizedBox(width: 16),
              ],
              if (chestController != null)
                InputField(
                  title: BodyInfoInputType.chest.label,
                  unit: BodyInfoInputType.chest.unit,
                  controller: chestController!,
                  onChanged: notifier.onChangedChest,
                ),
            ],
          ),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.unit,
    required this.controller,
    required this.onChanged,
    this.hintText = '--.-',
  });

  final String title;
  final String unit;
  final String hintText;
  final FormControl<String> controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidateTextField(
          width: 112,
          title: title,
          hintText: hintText,
          type: ValidateTextFieldType.double,
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: TextInputType.datetime,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Text(
            unit,
            style: IHSTextStyle.small,
          ),
        ),
      ],
    );
  }
}
