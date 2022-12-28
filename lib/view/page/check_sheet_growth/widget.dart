import 'package:family_notes/gen/assets.gen.dart';
import 'package:family_notes/view/component/ihs_button/type.dart';
import 'package:family_notes/view/component/ihs_button/widget.dart';
import 'package:family_notes/view/component/loading_indicator/widget.dart';
import 'package:family_notes/view/component/multiline_text_field/widget.dart';
import 'package:family_notes/view/page/check_sheet_growth/notifier.dart';
import 'package:family_notes/view/page/check_sheet_growth/status.dart';
import 'package:family_notes/view/page/check_sheet_growth_result/widget.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../util/util.dart';
import '../../component/gradation_layout/widget.dart';
import 'state.dart';

/// 発達チェックシート画面
class CheckSheetGrowthPage extends ConsumerWidget {
  const CheckSheetGrowthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkSheetGrowthProvider);
    final notifier = ref.watch(checkSheetGrowthProvider.notifier);

    return GradationLayout(
        title: '発達チェックシート',
        showDrawer: false,
        body: state.map(
          loading: (_) => const LoadingIndicator(),
          loaded: (loadedState) {
            final list = loadedState.list;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '未回答のみにすることの説明',
                      style: IHSTextStyle.small,
                    ),
                    const SizedBox(height: 20),
                    _SwicthTileArea(
                      isShowOnlyUnAnswered: loadedState.isShowOnlyUnAnswered,
                      notifier: notifier,
                    ),
                    const SizedBox(height: 40),
                    for (final category in list)
                      Visibility(
                        visible: category.isShowQuestionCategoryArea,
                        child: _QuestionCategoryArea(
                          categoryState: category,
                          notifier: notifier,
                        ),
                      ),
                    Center(
                      child: IHSButton(
                        '登録する',
                        type: IHSButtonType.primary,
                        onPressed: () async {
                          IHSUtil.showLoadingDialog(context);
                          await notifier.onTapSave(
                            onSuccess: (result) async {
                              Navigator.pop(context);
                              IHSUtil.showSnackBar(msg: IHSTexts.createSuccess);
                              // 画面遷移後ににスナックバーが表示され動きが不自然なため
                              await Future.delayed(const Duration(seconds: 1));
                              await Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      CheckSheetGrowthResultPage(
                                    answerResult: result,
                                  ),
                                ),
                              );
                            },
                            onFailure: (msg) {
                              Navigator.pop(context);
                              IHSUtil.showSnackBar(msg: msg);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class _SwicthTileArea extends StatelessWidget {
  const _SwicthTileArea({
    required this.isShowOnlyUnAnswered,
    required this.notifier,
  });

  final bool isShowOnlyUnAnswered;
  final CheckSheetGrowthNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notifier
          ..onChangedIsShowOnlyUnAnswered(value: !isShowOnlyUnAnswered)
          ..onChangedIsShowQuestionArea()
          ..onChangedIsShowQuestionCategoryArea();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '未回答のみにする。',
            style: IHSTextStyle.small,
          ),
          Switch(
            value: isShowOnlyUnAnswered,
            activeColor: IHSColors.pink400,
            onChanged: (value) {
              notifier
                ..onChangedIsShowOnlyUnAnswered(value: value)
                ..onChangedIsShowQuestionArea()
                ..onChangedIsShowQuestionCategoryArea();
            },
          )
        ],
      ),
    );
  }
}

class _QuestionCategoryArea extends StatelessWidget {
  const _QuestionCategoryArea({
    required this.categoryState,
    required this.notifier,
  });

  final GrowthDetailCategoryState categoryState;
  final CheckSheetGrowthNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryState.category,
          style: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink400,
          ),
        ),
        const Divider(color: IHSColors.pink200),
        const SizedBox(height: 16),
        _QuestionListArea(
          category: categoryState,
          notifier: notifier,
        ),
      ],
    );
  }
}

class _QuestionListArea extends StatelessWidget {
  const _QuestionListArea({
    required this.category,
    required this.notifier,
  });

  final GrowthDetailCategoryState category;
  final CheckSheetGrowthNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final questionList = category.questionList.map((e) {
      final isNoCheck = GrowthQuestionCheckStatus.no.value == e.isCheck;

      return Visibility(
        visible: e.isShowQuestionArea,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.question,
              style: IHSTextStyle.small,
            ),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () {
                  notifier
                    ..onTapCheck(
                      categoryId: category.id,
                      questionId: e.questionId,
                    )
                    ..onChangedIsShowQuestionArea()
                    ..onChangedIsShowQuestionCategoryArea();
                },
                child: SvgPicture.asset(
                  isNoCheck
                      ? Assets.images.tapFace
                      : Assets.images.tapFaceActive,
                  color: isNoCheck ? IHSColors.black300 : IHSColors.pink400,
                ),
              ),
            ),
            Visibility(
              visible: isNoCheck,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '当てはまっていたらタップしてください。',
                      style: IHSTextStyle.xSmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            MultilineTextField(
              controller: e.noteController,
              maxLines: 4,
              hintText: '自由に記入してください。',
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    }).toList();

    return Column(children: questionList);
  }
}
