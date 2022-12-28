import 'package:family_notes/view/component/gradation_layout/widget.dart';
import 'package:family_notes/view/component/home_button/widget.dart';
import 'package:family_notes/view/page/life_habit_question_result/state.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';

/// 生活習慣設問回答結果、総合コメント画面
class LifeHabitQuestionResultGeneralCommentPage extends StatelessWidget {
  const LifeHabitQuestionResultGeneralCommentPage({
    super.key,
    required this.generalComment,
  });

  final GeneralCommentState generalComment;

  @override
  Widget build(BuildContext context) {
    return GradationLayout(
      title: '生活習慣改善チェックシート',
      showDrawer: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '総合コメント',
                style: IHSTextStyle.medium.copyWith(color: IHSColors.pink500),
              ),
              const SizedBox(height: 32),
              _GeneralCommentArea(generalCommentState: generalComment),
              const HomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GeneralCommentArea extends StatelessWidget {
  const _GeneralCommentArea({required this.generalCommentState});

  final GeneralCommentState generalCommentState;

  @override
  Widget build(BuildContext context) {
    final perfectComment = generalCommentState.perfectComment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: perfectComment.isEmpty
          ? generalCommentState.categoryList.map((e) {
              return _CategoryArea(categoryState: e);
            }).toList()
          : [
              Text(perfectComment),
              const SizedBox(height: 32),
            ],
    );
  }
}

class _CategoryArea extends StatelessWidget {
  const _CategoryArea({required this.categoryState});

  final CategoryState categoryState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryState.name,
          style: IHSTextStyle.small.copyWith(color: IHSColors.pink400),
        ),
        const Divider(color: IHSColors.pink200),
        for (final commnet in categoryState.commentList)
          Column(
            children: [
              Text(commnet.content, style: IHSTextStyle.small),
              const SizedBox(height: 32),
            ],
          ),
      ],
    );
  }
}
