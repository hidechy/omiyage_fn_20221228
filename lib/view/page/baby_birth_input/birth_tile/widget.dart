import 'package:family_notes/extension/int.dart';
import 'package:family_notes/view/component/time_pick_text_field/widget.dart';
import 'package:family_notes/view/style/constants.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/view/style/colors.dart';
import '../../../component/date_pick_text_field/widget.dart';
import '../../../component/plain_text_field/widget.dart';
import '../body_input/widget.dart';
import '../notifier.dart';
import '../segment_view/widget.dart';
import '../type.dart';

/// お子さまの出生情報を表示
class BabyBirthTile extends ConsumerStatefulWidget {
  const BabyBirthTile({
    super.key,
    required this.showTitle,
    required this.data,
    required this.onChanged,
  });

  // 第○子の表示の有無
  final bool showTitle;
  final BabyBirthDataByChild data;
  final Function(BabyBirthDataByChild) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BabyBirthTileState();
}

class _BabyBirthTileState extends ConsumerState<BabyBirthTile> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.data.name);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formGroups = ref.watch(babyBirthInputStateProvider
        .select((s) => s.mapOrNull(loaded: (s) => s.form)))!;
    final _index = widget.data.index;
    final _formGroup = formGroups.control(_index.toString()) as FormGroup;

    return ReactiveForm(
      formGroup: _formGroup,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: IHSColors.white,
          border: Border.all(
            color: IHSColors.black300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showTitle) _buildTitle(),
            PlainTextField(
              controller: nameController,
              title: '名前（ニックネーム）',
              onChanged: (text) =>
                  widget.onChanged(widget.data.copyWith(name: text)),
            ),
            const SizedBox(height: 24),
            DatePickTextField(
              widget.data.birthday,
              title: '出産日',
              onChanged: (date) {
                widget.onChanged(widget.data.copyWith(birthday: date));
              },
              firstDate: IHSConstants.datePickerFirstDateYearNum,
              lastDate: IHSConstants.datePickerLastDateYearNum,
            ),
            const SizedBox(height: 24),
            TimePickTextField(
              widget.data.birthdayTime,
              title: '出産時刻',
              onChanged: (time) {
                widget.onChanged(widget.data.copyWith(birthdayTime: time));
              },
            ),
            const SizedBox(height: 24),
            _buildGenderField(context),
            const SizedBox(height: 24),
            BabyBirthBodyInput(
              data: widget.data,
              onChanged: (type, text) {
                switch (type) {
                  case BabyBirthBodyInputType.height:
                    widget.onChanged(widget.data.copyWith(height: text));

                    break;
                  case BabyBirthBodyInputType.weight:
                    widget.onChanged(widget.data.copyWith(weight: text));

                    break;
                  case BabyBirthBodyInputType.head:
                    widget.onChanged(widget.data.copyWith(head: text));

                    break;
                  case BabyBirthBodyInputType.chest:
                    widget.onChanged(widget.data.copyWith(chest: text));

                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '第${(widget.data.index + 1).toChineseString}子',
          style: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink500,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          height: 1,
          thickness: 1,
          color: IHSColors.black400,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// 性別の選択フィールド
  Widget _buildGenderField(
    BuildContext context,
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
        ChildGenderSegmentView(
          selectedType: widget.data.gender,
          onTap: (value) {
            widget.onChanged(widget.data.copyWith(gender: value));
          },
        ),
      ],
    );
  }
}
