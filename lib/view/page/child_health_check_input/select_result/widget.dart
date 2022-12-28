import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../notifier.dart';
import '../type.dart';

class SelectResult extends ConsumerWidget {
  const SelectResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(childHealthCheckInputProvider.notifier);
    final _result = ref.watch(childHealthCheckInputProvider
        .select((s) => s.mapOrNull(loaded: (s) => s.inputData.result)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '健診結果',
          style: IHSTextStyle.small.copyWith(
            color: IHSColors.black800,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<ChildCheckUpResultType>(
          hint: Text(
            'リストから選択してください',
            style: IHSTextStyle.small.copyWith(color: IHSColors.black400),
          ),
          style: IHSTextStyle.small.copyWith(color: IHSColors.black800),
          elevation: 0,
          decoration: const InputDecoration(
            filled: true,
            fillColor: IHSColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: IHSColors.black800, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: IHSColors.black800, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          items: checkTypeList
              .map(
                (checkType) => DropdownMenuItem(
                  value: checkType,
                  child: Text(
                    checkType.label,
                    style: IHSTextStyle.small,
                  ),
                ),
              )
              .toList(),
          value: _result,
          onChanged: notifier.selectCheckResult,
        )
      ],
    );
  }
}
