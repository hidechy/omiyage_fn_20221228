import 'dart:async';

import 'package:family_notes/view/service/navigation.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:flutter/material.dart';

import '../view/component/loading_indicator/widget.dart';
import '../view/style/text_style.dart';

class IHSUtil {
  IHSUtil._();

  static void showSnackBar({required String msg}) {
    final navigatorContext = NavigationService.navigatorKey.currentContext!;
    ScaffoldMessenger.of(navigatorContext).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                msg,
                style: IHSTextStyle.small.copyWith(color: IHSColors.pink500),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(navigatorContext).hideCurrentSnackBar();
              },
              child: const Icon(
                Icons.close,
                color: IHSColors.pink400,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: IHSColors.pink500),
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: IHSColors.pink50,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
        elevation: 0,
      ),
    );
  }

  /// 保存中の画面全体を覆うローディングダイアログ
  static void showLoadingDialog(BuildContext context) {
    unawaited(
      showGeneralDialog(
        context: context,
        barrierColor: IHSColors.black900.withAlpha(66),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoadingIndicator();
        },
      ),
    );
  }
}
