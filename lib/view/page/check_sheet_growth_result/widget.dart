import 'package:family_notes/view/component/gradation_layout/widget.dart';
import 'package:family_notes/view/component/ihs_button/type.dart';
import 'package:family_notes/view/component/ihs_button/widget.dart';
import 'package:family_notes/view/page/check_sheet_growth_result/notifier.dart';
import 'package:family_notes/view/page/check_sheet_growth_result/type.dart';
import 'package:family_notes/view/page/check_sheet_support/widget.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/home_button/widget.dart';

/// 発達チェックシート入力結果画面
class CheckSheetGrowthResultPage extends ConsumerWidget {
  const CheckSheetGrowthResultPage({
    super.key,
    required this.answerResult,
  });

  final int answerResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkSheetGrowthResultProvider(answerResult));

    return GradationLayout(
      title: 'チェックシート',
      showDrawer: false,
      automaticallyImplyLeading: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: _buildAnswerResultArea(state.resultType),
        ),
      ),
    );
  }

  Widget _buildAnswerResultArea(GrowthQuestionAnswerResultType type) {
    switch (type) {
      case GrowthQuestionAnswerResultType.maternalAndChildProtectionDivision:
        return const _MaternalAndChildProtectionDivisionArea();
      case GrowthQuestionAnswerResultType.communitySupportCenter:
        return const _CommunitySupportCenterArea();
      case GrowthQuestionAnswerResultType.none:
        return const _NoneArea();
    }
  }
}

class _MaternalAndChildProtectionDivisionArea extends StatelessWidget {
  const _MaternalAndChildProtectionDivisionArea();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'お子さまの発達や行動に関して、ご心配なことがありましたら、母子保健課までご相談ください。',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 40),
        const _PushButton(),
        const SizedBox(height: 40),
        const HomeButton(),
      ],
    );
  }
}

class _CommunitySupportCenterArea extends StatelessWidget {
  const _CommunitySupportCenterArea();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'お子さまの発達や行動に関して、ご心配なことがありましたら、地域支援センターまでご相談ください。',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 40),
        Text(
          'おひさま相談',
          style: IHSTextStyle.small.copyWith(color: IHSColors.pink400),
        ),
        Text(
          '5歳〜就学まで。',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 24),
        Text(
          '外来相談',
          style: IHSTextStyle.small.copyWith(color: IHSColors.pink400),
        ),
        Text(
          '小学1年〜18歳まで。',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 40),
        const Center(child: _PushButton()),
        const SizedBox(height: 40),
        const Center(child: HomeButton()),
      ],
    );
  }
}

class _NoneArea extends StatelessWidget {
  const _NoneArea();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'サポートチェックシートへの誘導不要のパターンの画面。ダミーテキストです。',
          style: IHSTextStyle.small,
        ),
        const SizedBox(height: 40),
        const HomeButton(),
      ],
    );
  }
}

class _PushButton extends StatelessWidget {
  const _PushButton();

  @override
  Widget build(BuildContext context) {
    return IHSButton(
      'サポートチェックシートをやってみる',
      type: IHSButtonType.primary,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CheckSheetSupportPage(),
          ),
        );
      },
    );
  }
}
