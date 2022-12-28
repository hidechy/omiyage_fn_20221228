import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/view/component/main_layout/widget.dart';
import '/view/page/baby_input/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../style/text_style.dart';
import '../child_input/widget.dart';

/// プロフィール入力完了画面
class ProfileInputCompletedPage extends ConsumerWidget {
  const ProfileInputCompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainLayout(
      showAppBar: false,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            '次にお子さまを登録してください。',
            textAlign: TextAlign.center,
            style: IHSTextStyle.small,
          ),
          const SizedBox(height: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IHSButton(
                '胎児の登録',
                type: IHSButtonType.primary,
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (_, __, ___) => const BabyInputPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              IHSButton(
                'お子さまの登録',
                type: IHSButtonType.primary,
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (_, __, ___) => const ChildInputPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
