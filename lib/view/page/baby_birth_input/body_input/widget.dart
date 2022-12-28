import 'package:family_notes/view/component/validate_text_field/type.dart';
import 'package:family_notes/view/component/validate_text_field/widget.dart';
import 'package:family_notes/view/page/baby_birth_input/notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../style/text_style.dart';
import '../type.dart';

enum BabyBirthBodyInputType {
  /// 身長
  height,

  /// 体重
  weight,

  /// 頭囲
  head,

  /// 胸囲
  chest,
}

extension BabyBirthBodyInputTypeEx on BabyBirthBodyInputType {
  String get label {
    switch (this) {
      case BabyBirthBodyInputType.height:
        return '身長';
      case BabyBirthBodyInputType.weight:
        return '体重';
      case BabyBirthBodyInputType.head:
        return '頭囲';
      case BabyBirthBodyInputType.chest:
        return '胸囲';
    }
  }

  String get unit {
    switch (this) {
      case BabyBirthBodyInputType.height:
        return 'cm';
      case BabyBirthBodyInputType.weight:
        return 'g';
      case BabyBirthBodyInputType.head:
        return 'cm';
      case BabyBirthBodyInputType.chest:
        return 'cm';
    }
  }
}

class BabyBirthBodyInput extends ConsumerWidget {
  const BabyBirthBodyInput({
    super.key,
    required this.data,
    required this.onChanged,
  });

  final BabyBirthDataByChild data;
  final Function(BabyBirthBodyInputType, String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroups = ref.watch(babyBirthInputStateProvider
        .select((s) => s.mapOrNull(loaded: (s) => s.form)))!;
    final _index = data.index;
    final _formGroup = formGroups.control(_index.toString()) as FormGroup;
    final _heightController = _formGroup
        .control(BabyBirthBodyInputType.height.name) as FormControl<String>;
    final _weightController = _formGroup
        .control(BabyBirthBodyInputType.weight.name) as FormControl<String>;
    final _headController = _formGroup.control(BabyBirthBodyInputType.head.name)
        as FormControl<String>;
    final _chestController = _formGroup
        .control(BabyBirthBodyInputType.chest.name) as FormControl<String>;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InputField(
                controller: _heightController,
                title: BabyBirthBodyInputType.height.label,
                unit: BabyBirthBodyInputType.height.unit,
                onChanged: (value) {
                  onChanged(BabyBirthBodyInputType.height, value);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _InputField(
                controller: _weightController,
                title: BabyBirthBodyInputType.weight.label,
                unit: BabyBirthBodyInputType.weight.unit,
                onChanged: (value) {
                  onChanged(BabyBirthBodyInputType.weight, value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InputField(
                controller: _headController,
                title: BabyBirthBodyInputType.head.label,
                unit: BabyBirthBodyInputType.head.unit,
                onChanged: (value) {
                  onChanged(BabyBirthBodyInputType.head, value);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _InputField(
                controller: _chestController,
                title: BabyBirthBodyInputType.chest.label,
                unit: BabyBirthBodyInputType.chest.unit,
                onChanged: (value) {
                  onChanged(BabyBirthBodyInputType.chest, value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.title,
    required this.unit,
    required this.controller,
    required this.onChanged,
  });

  final String title;
  final String unit;
  final FormControl<String> controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidateTextField(
          width: 96,
          type: ValidateTextFieldType.int,
          keyboardType: TextInputType.number,
          controller: controller,
          title: title,
          hintText: '----',
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
