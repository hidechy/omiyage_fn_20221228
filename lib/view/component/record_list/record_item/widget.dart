import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 記録一覧で使用するアイテム
class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.date,
    this.title,
    this.onTap,
  });

  final DateTime date;
  final String? title;
  final VoidCallback? onTap;

  String get dateString {
    final fmt = DateFormat('yyyy/MM/dd');
    return fmt.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        color: IHSColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                dateString,
                style: IHSTextStyle.small,
              ),
            ),
            if (title != null)
              Expanded(
                child: Text(
                  title!,
                  style: IHSTextStyle.small,
                ),
              ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: IHSColors.black800,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
