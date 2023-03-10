import 'package:family_notes/view/component/ihs_button/type.dart';
import 'package:family_notes/view/component/ihs_button/widget.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../state.dart';

/// コメント表示ダイアログ
class CommentDialog extends StatelessWidget {
  const CommentDialog({super.key, required this.question});

  final QuestionAnswerResultState question;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      title: question.pointAssetName.isEmpty
          ? const SizedBox.shrink()
          : SvgPicture.asset(
              question.pointAssetName,
              width: 144,
              height: 40,
            ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              question.comment,
              style: IHSTextStyle.small,
            ),
          ),
          const SizedBox(height: 24),
          SvgPicture.asset(
            question.assetName,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 24),
          IHSButton(
            '閉じる',
            type: IHSButtonType.primary,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
