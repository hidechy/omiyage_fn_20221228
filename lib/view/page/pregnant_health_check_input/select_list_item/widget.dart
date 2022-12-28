import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../state.dart';

/// チェックリストに表示するアイテム（健診入力画面の健診結果リストなどで使用）
class SelectListItem extends StatefulWidget {
  const SelectListItem({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final PregnantHealthCheckInputListItemType type;
  final bool selected;

  final Function(PregnantHealthCheckInputListItemType, bool) onTap;

  @override
  State<SelectListItem> createState() => _SelectListItemState();
}

class _SelectListItemState extends State<SelectListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          widget.onTap(widget.type, !widget.selected);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.type.label,
                  style: IHSTextStyle.small.copyWith(
                    color: widget.selected
                        ? IHSColors.black800
                        : IHSColors.black400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                activeColor:
                    widget.selected ? IHSColors.black800 : IHSColors.black400,
                value: widget.selected,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
