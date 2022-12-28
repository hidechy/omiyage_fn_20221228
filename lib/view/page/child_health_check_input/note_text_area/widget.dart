import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../component/multiline_text_field/widget.dart';
import '../../../style/text_style.dart';
import '../notifier.dart';

class MemoTextArea extends ConsumerWidget {
  const MemoTextArea({
    super.key,
    required this.memoController,
  });

  final TextEditingController memoController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(childHealthCheckInputProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メモ',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: memoController,
          hintText: '自由に入力してください',
          minLines: 4,
          onChanged: notifier.onChangedNote,
        ),
      ],
    );
  }
}
