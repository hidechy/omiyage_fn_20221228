import 'package:family_notes/view/component/base_app_bar/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../style/colors.dart';
import '../drawer_menu/widget.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({
    super.key,
    required this.body,
    this.title,
    this.backgroundColor = Colors.white,
    this.showAppBar = true,
    this.showDrawer = true,
    this.automaticallyImplyLeading = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });
  final String? title;
  final Widget body;
  final Color backgroundColor;
  final bool showAppBar;
  final bool showDrawer;
  final bool automaticallyImplyLeading;
  final EdgeInsets padding;

  EdgeInsets get margin =>
      const EdgeInsets.symmetric(vertical: 24, horizontal: 16);

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
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
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
