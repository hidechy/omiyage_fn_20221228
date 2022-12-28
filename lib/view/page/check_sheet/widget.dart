import 'package:family_notes/view/page/check_sheet_growth/widget.dart';
import 'package:family_notes/view/page/check_sheet_support/widget.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';

/// チェックシート選択画面
class CheckSheetSelectPage extends ConsumerWidget {
  const CheckSheetSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradationLayout(
      title: 'チェックシート',
      showDrawer: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'お子さまの発達チェックをご活用ください。(ダミーテキストです)',
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 32),
              IHSButton(
                '発達チェックシート',
                type: IHSButtonType.primary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CheckSheetGrowthPage(),
                  ));
                },
              ),
              const SizedBox(height: 32),
              Text(
                'サポートをご希望の場合はこちらのチェックシートをご活用ください。(ダミーテキストです)',
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 32),
              IHSButton(
                'サポートチェックシート',
                type: IHSButtonType.primary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CheckSheetSupportPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
