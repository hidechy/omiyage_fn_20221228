import 'package:family_notes/view/component/main_layout/widget.dart';
import 'package:flutter/material.dart';

/// 「メールが届かない場合」画面
class UndeliverdEmailPage extends StatelessWidget {
  const UndeliverdEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      title: 'メールが届かない場合',
      showDrawer: false,
      body: Placeholder(),
    );
  }
}
