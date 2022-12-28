import 'package:family_notes/gen/assets.gen.dart';
import 'package:family_notes/view/component/loading_indicator/widget.dart';
import 'package:family_notes/view/page/life_habit_question_general_comment/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/ihs_image_button/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'dialog/widget.dart';
import 'notifier.dart';
import 'state.dart';
import 'type.dart';

/// 生活習慣設問回答結果画面
class LifeHabitQuestionResultPage extends ConsumerWidget {
  const LifeHabitQuestionResultPage({
    super.key,
    required this.type,
    required this.answerHeaderId,
    required this.date,
  });

  final QuestionAnswerResultType type;
  final int answerHeaderId;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status =
        ref.watch(lifeHabitQuestionResultStateProvider(answerHeaderId));

    return GradationLayout(
      title: '生活習慣改善チェックシート',
      showDrawer: false,
      // 入力履歴からの遷移の場合は戻るボタン必要のため
      automaticallyImplyLeading: QuestionAnswerResultType.past == type,
      body: status.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (loadedState) {
          final questions = loadedState.list;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      _buildText(date),
                      _buildText('回答結果'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  IHSButton(
                    '総合コメントを見る',
                    type: IHSButtonType.primary,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              LifeHabitQuestionResultGeneralCommentPage(
                            generalComment: loadedState.generalComment,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  for (var index = 0; index < questions.length; index++)
                    _AnswerResultArea(question: questions[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: IHSTextStyle.medium.copyWith(
        color: IHSColors.pink500,
      ),
    );
  }
}

/// 回答結果表示
class _AnswerResultArea extends StatelessWidget {
  const _AnswerResultArea({required this.question});

  final QuestionAnswerResultState question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: IHSColors.pink300),
        const SizedBox(height: 24),
        SvgPicture.asset(
          question.assetName,
          width: 40,
          height: 24,
        ),
        const SizedBox(height: 8),
        Text(
          'Question.${question.id}',
          style: IHSTextStyle.small.copyWith(
            color: IHSColors.pink400,
          ),
        ),
        const SizedBox(height: 8),
        Text(question.content, style: IHSTextStyle.small),
        const SizedBox(height: 16),
        _ChoiceListArea(
          choices: question.choices,
          answerChoiceId: question.answer,
        ),
        const SizedBox(height: 16),
        Align(
          child: question.pointAssetName.isEmpty
              ? const SizedBox.shrink()
              : SvgPicture.asset(question.pointAssetName),
        ),
        const SizedBox(height: 16),
        Align(
          child: IHSImageButton(
            SvgPicture.asset(Assets.images.iconComment),
            title: 'コメントを見る',
            horizontalMargin: 16,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CommentDialog(question: question);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// 設問に紐づいた選択肢の表示
class _ChoiceListArea extends StatelessWidget {
  const _ChoiceListArea({
    required this.choices,
    required this.answerChoiceId,
  });

  final List<ChoiceState> choices;
  final int answerChoiceId;

  @override
  Widget build(BuildContext context) {
    /// 選択肢テキスト一覧
    final texts = choices.map((e) {
      final content = e.content;
      return Visibility(
        visible: content.isNotEmpty,
        child: Flexible(
            child: Center(
          child: FittedBox(
            child: Text(
              content,
              style: IHSTextStyle.xSmall,
            ),
          ),
        )),
      );
    }).toList();

    final deviceWidth = MediaQuery.of(context).size.width;
    const gradiationLayoutPadding = 24;
    final choiceAreaWidth = deviceWidth - gradiationLayoutPadding * 2;
    final padding = choiceAreaWidth / (choices.length - 1) / 2;

    final verticalBars = <Widget>[];
    choices.asMap().forEach((index, e) {
      final selected = e.id == answerChoiceId;
      if (e.content.isNotEmpty) {
        verticalBars.add(
          _buildVertialLine(
            selected: selected,
          ),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: texts,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: verticalBars,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: const Divider(
            color: IHSColors.pink100,
            height: 1,
            thickness: 1,
          ),
        )
      ],
    );
  }

  Widget _buildVertialLine({required bool selected}) {
    return SizedBox(
      width: 24,
      child: Column(
        children: [
          selected
              ? const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: IHSColors.pink400,
                  size: 24,
                )
              : const SizedBox(height: 24),
          Container(
            height: 10,
            width: 1,
            color: IHSColors.pink100,
          ),
        ],
      ),
    );
  }
}
