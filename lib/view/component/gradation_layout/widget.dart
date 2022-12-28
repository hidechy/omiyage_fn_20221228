import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../style/colors.dart';
import '../base_app_bar/widget.dart';
import '../drawer_menu/widget.dart';

/// グラデーション背景のレイアウト（ホーム画面などで使用）
class GradationLayout extends ConsumerWidget {
  const GradationLayout({
    super.key,
    required this.body,
    this.title,
    this.showAppBar = true,
    this.showDrawer = true,
    this.automaticallyImplyLeading = true,
    this.horizontalPadding = 24,
  });
  final String? title;
  final Widget body;
  final bool showAppBar;
  final bool showDrawer;
  final bool automaticallyImplyLeading;
  final double horizontalPadding;

  EdgeInsets get margin => const EdgeInsets.symmetric(vertical: 24);
  EdgeInsets get padding => EdgeInsets.symmetric(horizontal: horizontalPadding);

  Color get gradationColor => Colors.white;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: IHSColors.pink100,
      appBar: showAppBar
          ? BaseAppBar(
              title: title,
              automaticallyImplyLeading: automaticallyImplyLeading,
            )
          : null,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                IHSColors.white,
                IHSColors.yellow50,
              ],
              stops: [
                0.0,
                1.0,
              ],
            ),
          ),
          padding: padding,
          margin: margin,
          child: body,
        ),
      ),
      endDrawer: (showAppBar && showDrawer) ? dispDrawer(context) : null,
    );
  }

  Widget dispDrawer(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: IHSColors.yellow50,
      ),
      child: const DrawerMenu(),
    );
  }
}
