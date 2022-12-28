import 'package:family_notes/gen/assets.gen.dart';
import 'package:family_notes/util/util.dart';
import 'package:family_notes/view/component/loading_indicator/widget.dart';
import 'package:family_notes/view/page/check_sheet_support/notifier.dart';
import 'package:family_notes/view/page/check_sheet_support/state.dart';
import 'package:family_notes/view/page/check_sheet_support_result/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/multiline_text_field/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../../style/texts.dart';
import 'status.dart';

/// サポートチェックシート画面
class CheckSheetSupportPage extends ConsumerWidget {
  const CheckSheetSupportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkSheetSupportProvider);
    final notifier = ref.watch(checkSheetSupportProvider.notifier);

    return GradationLayout(
      title: 'サポートチェックシート',
      showDrawer: false,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (loadedState) {
          final largeCategoryList = loadedState.largeCategoryList;

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
                    label: '回答済みのみにする。',
                    isShow: loadedState.isShowOnlyAnswered,
                    onTap: () {
                      notifier
                        ..onChangedIsShowOnlyAnswered(
                          value: !loadedState.isShowOnlyAnswered,
                        )
                        ..onChangedIsShowQuestionArea()
                        ..onChangedIsShowSmallCategoryArea()
                        ..onChangedIsShowLargeCategoryArea();
                    },
                    onChanged: (value) {
                      notifier
                        ..onChangedIsShowOnlyAnswered(value: value)
                        ..onChangedIsShowQuestionArea()
                        ..onChangedIsShowSmallCategoryArea()
                        ..onChangedIsShowLargeCategoryArea();
                    },
                  ),
                  const SizedBox(height: 40),
                  for (final largeCategory in largeCategoryList)
                    Visibility(
                      visible: largeCategory.isShowLargeCategoryArea,
                      child: _LargeCategoryArea(
                        isShowOnlyAnswered: loadedState.isShowOnlyAnswered,
                        largeCategoryState: largeCategory,
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
                          onSuccess: () async {
                            Navigator.pop(context);
                            IHSUtil.showSnackBar(msg: IHSTexts.createSuccess);
                            await Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const CheckSheetSupportResultPage(),
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
      ),
    );
  }
}

class _SwicthTileArea extends StatelessWidget {
  const _SwicthTileArea({
    required this.label,
    required this.isShow,
    required this.onTap,
    required this.onChanged,
  });

  final String label;
  final bool isShow;
  final VoidCallback onTap;
  final Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: IHSTextStyle.small,
          ),
          Switch(
            value: isShow,
            activeColor: IHSColors.pink400,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}

class _LargeCategoryArea extends StatelessWidget {
  const _LargeCategoryArea({
    required this.isShowOnlyAnswered,
    required this.largeCategoryState,
    required this.notifier,
  });

  final bool isShowOnlyAnswered;
  final CheckSheetSupportLargeCategoryState largeCategoryState;
  final CheckSheetSupportNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          largeCategoryState.name,
          style: IHSTextStyle.medium.copyWith(
            color: IHSColors.pink400,
          ),
        ),
        const Divider(color: IHSColors.pink200),
        const SizedBox(height: 16),
        for (final smallCategory in largeCategoryState.smallCategoryList)
          Visibility(
            visible: smallCategory.isShowSmallCategoryArea,
            child: _SmallCategoryArea(
              isShowOnlyAnswered: isShowOnlyAnswered,
              largeCategoryId: largeCategoryState.id,
              smallCategoryState: smallCategory,
              notifier: notifier,
            ),
          )
      ],
    );
  }
}

class _SmallCategoryArea extends StatelessWidget {
  const _SmallCategoryArea({
    required this.isShowOnlyAnswered,
    required this.smallCategoryState,
    required this.notifier,
    required this.largeCategoryId,
  });

  final bool isShowOnlyAnswered;
  final int largeCategoryId;
  final CheckSheetSupportSmallCategoryState smallCategoryState;
  final CheckSheetSupportNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          smallCategoryState.name,
          style: IHSTextStyle.small.copyWith(
            color: IHSColors.pink400,
          ),
        ),
        const SizedBox(height: 16),
        _QuestionListArea(
          isShowOnlyAnswered: isShowOnlyAnswered,
          largeCategoryId: largeCategoryId,
          smallCategoryId: smallCategoryState.id,
          questionStateList: smallCategoryState.questionList,
          notifier: notifier,
        )
      ],
    );
  }
}

class _QuestionListArea extends StatelessWidget {
  const _QuestionListArea({
    required this.isShowOnlyAnswered,
    required this.largeCategoryId,
    required this.smallCategoryId,
    required this.questionStateList,
    required this.notifier,
  });

  final bool isShowOnlyAnswered;
  final int largeCategoryId;
  final int smallCategoryId;
  final List<SupportQuestionState> questionStateList;
  final CheckSheetSupportNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final questionList = questionStateList.map((e) {
      final isNoCheck = SupportQuestionCheckStatus.no.value == e.isCheck;

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
                  if (isShowOnlyAnswered) {
                    notifier
                      ..onTapCheck(
                        largeCategoryId: largeCategoryId,
                        smallCategoryId: smallCategoryId,
                        questionId: e.questionId,
                      )
                      ..onChangedIsShowQuestionArea()
                      ..onChangedIsShowSmallCategoryArea()
                      ..onChangedIsShowLargeCategoryArea();
                    return;
                  }

                  notifier.onTapCheck(
                    largeCategoryId: largeCategoryId,
                    smallCategoryId: smallCategoryId,
                    questionId: e.questionId,
                  );
                },
                child: SvgPicture.asset(
                  isNoCheck
                      ? Assets.images.tapClover
                      : Assets.images.tapCloverActive,
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
