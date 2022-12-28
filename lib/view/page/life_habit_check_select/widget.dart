import 'package:family_notes/view/page/life_habit_check_work_sheet/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../gen/assets.gen.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../style/text_style.dart';

/// 生活習慣病予防
class LifeHabitCheckSelectPage extends ConsumerWidget {
  const LifeHabitCheckSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradationLayout(
      title: '生活習慣病予防',
      showDrawer: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '生活習慣予防改善チェックシートの入力又は検査結果の参照を選択して下さい。',
                  style: IHSTextStyle.small,
                ),
              ),
              const SizedBox(height: 32),
              _ButtonArea(
                buttonTitle: '生活習慣改善チェックシート',
                image: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SvgPicture.asset(
                    Assets.images.lifeHabitCheckSheetLogo,
                    height: 47.42,
                    width: 50,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LifeHabitCheckWorkSheetPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              _ButtonArea(
                buttonTitle: '吹田市生活習慣病予防健診',
                image: SvgPicture.asset(
                  Assets.images.suitaLogo,
                  height: 51.67,
                  width: 50,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 32),
              _ButtonArea(
                buttonTitle: '国循生活習慣病予防健診',
                image: Image.asset(
                  Assets.images.kokuzixyunLogo.path,
                  height: 50,
                  width: 81.73,
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 56),
              Text(
                '国循データプラットフォームとの連携・解除を行います。(ダミーテキストです。)',
                style: IHSTextStyle.small,
              ),
              const SizedBox(height: 32),
              IHSButton(
                '国循データプラットフォーム\n連携・解除',
                type: IHSButtonType.primary,
                textAlign: TextAlign.center,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonArea extends StatelessWidget {
  const _ButtonArea({
    required this.buttonTitle,
    required this.image,
    this.onPressed,
  });

  final String buttonTitle;
  final Widget image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image,
        const SizedBox(height: 8),
        IHSButton(
          buttonTitle,
          type: IHSButtonType.primary,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
