import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.endItem,
  });

  final String buttonText;
  final VoidCallback onTap;
  final bool endItem;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: endItem
            ? const Border(
                top: BorderSide(color: IHSColors.black200),
                bottom: BorderSide(color: IHSColors.black200),
              )
            : const Border(
                top: BorderSide(color: IHSColors.black200),
              ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(
            buttonText,
            style: IHSTextStyle.small,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
