import 'package:family_notes/view/component/loading_indicator/widget.dart';
import 'package:family_notes/view/page/life_habit_question/state.dart';
import 'package:family_notes/view/page/life_habit_question_result/type.dart';
import 'package:family_notes/view/page/life_habit_question_result/widget.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extension/date_time.dart';
import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'notifier.dart';

/// 生活習慣設問画面
class LifeHabitQuestionPage extends ConsumerWidget {
  const LifeHabitQuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lifeHabitQuestionStateProvider);
    final notifier = ref.watch(lifeHabitQuestionStateProvider.notifier);

    return GradationLayout(
      title: '生活習慣改善チェックシート',
      showDrawer: false,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (loadedState) {
          final questions = loadedState.list;
          final currentIndex = loadedState.inputData.currentQuestionIndex;
          final question = questions[currentIndex];
          final indexText = '${currentIndex + 1}';
          final questionIndexText = 'Question. $indexText/16';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          question.assetName,
                          width: 40,
                          height: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        questionIndexText,
                        style: IHSTextStyle.small.copyWith(
                          color: IHSColors.pink400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        question.content,
                        style: IHSTextStyle.small,
                      ),
                      const SizedBox(height: 16),
                      _PointTextArea(question: question),
                      const SizedBox(height: 28),
                      _ChoiceListArea(
                        choiceList: question.choices,
                        currentChoiceId: loadedState.inputData.currentChoiceId,
                        notifier: notifier,
                      ),
                      const SizedBox(height: 40),
                      _ButtonArea(
                        currentIndex: currentIndex,
                        notifier: notifier,
                        question: question,
                        questions: questions,
                      ),
                    ],
                  ),
                ),
                // 登録中画面状態
                Visibility(
                  visible: loadedState.saving,
                  child: const Positioned(
                    child: AbsorbPointer(
                      child: LoadingIndicator(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ポイント表示
class _PointTextArea extends StatelessWidget {
  const _PointTextArea({required this.question});

  final QuestionState question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IHSColors.pink50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Point',
            style: IHSTextStyle.small.copyWith(
              color: IHSColors.pink400,
            ),
          ),
          Text(
            question.hint,
            style: IHSTextStyle.small,
          ),
        ],
      ),
    );
  }
}

class _ButtonArea extends StatelessWidget {
  const _ButtonArea({
    required this.currentIndex,
    required this.notifier,
    required this.question,
    required this.questions,
  });

  final int currentIndex;
  final LifeHabitQuestionStateNotifier notifier;
  final QuestionState question;
  final List<QuestionState> questions;

  @override
  Widget build(BuildContext context) {
    /// 最後の質問のindex
    const lastQuestionIndex = 15;

    return Align(
      child: currentIndex != lastQuestionIndex
          ? IHSButton(
              '次へ',
              type: IHSButtonType.primary,
              onPressed: () {
                notifier
                  ..moveNextQuestion()
                  ..setAnswer(questionId: question.id)
                  ..setNextQuestionNoAnswerChoiceId(questions);
              },
            )
          : Column(
              children: [
                Text(
                  '回答お疲れ様でした。',
                  style: IHSTextStyle.small,
                ),
                const SizedBox(height: 32),
                IHSButton(
                  '回答結果を見る',
                  type: IHSButtonType.primary,
                  onPressed: () async {
                    notifier.setAnswer(questionId: question.id);
                    await notifier.onTapSave(
                      onSuccess: (answerHeaderId) async {
                        IHSUtil.showSnackBar(
                          msg: IHSTexts.createSuccess,
                        );
                        await Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                LifeHabitQuestionResultPage(
                              type: QuestionAnswerResultType.latest,
                              answerHeaderId: answerHeaderId,
                              date: DateTime.now().yyyymmdd,
                            ),
                          ),
                        );
                      },
                      onFailure: (msg) {
                        IHSUtil.showSnackBar(msg: msg);
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}

/// 選択肢一覧表示
class _ChoiceListArea extends StatelessWidget {
  const _ChoiceListArea({
    required this.choiceList,
    required this.currentChoiceId,
    required this.notifier,
  });

  final List<ChoiceState> choiceList;
  final int currentChoiceId;
  final LifeHabitQuestionStateNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final list = choiceList.map((e) {
      return e.content.isEmpty
          ? const SizedBox.shrink()
          : Column(
              children: [
                GestureDetector(
                  onTap: () {
                    notifier.onChangedCurrentChoiceId(e.id);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Radio(
                          value: e.id,
                          groupValue: currentChoiceId,
                          activeColor: IHSColors.black900,
                          onChanged: (_) {
                            // GestureDetectorにもRadio変更処理記載しているが、Radioタップ後にはGestureDetectorが発火してくれないため
                            notifier.onChangedCurrentChoiceId(e.id);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        e.content,
                        style: IHSTextStyle.small,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
            );
    }).toList();

    return Column(children: list);
  }
}
