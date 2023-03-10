import 'package:family_notes/data/repository/check_sheet_support.dart';
import 'package:family_notes/data/request/check_sheet_support_save/request.dart';
import 'package:family_notes/provider/user/notifier.dart';
import 'package:family_notes/view/page/check_sheet_support/state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import '../../style/texts.dart';
import 'status.dart';

final checkSheetSupportProvider = AutoDisposeStateNotifierProvider<
    CheckSheetSupportNotifier, CheckSheetSupportState>((ref) {
  final childId = ref
      .watch(userStateProvider)
      .mapOrNull(authenticated: (value) => value.selectedChildId);

  return CheckSheetSupportNotifier(
    ref: ref,
    childId: childId,
    checkSheetSupportRepository: ref.watch(checkSheetSupportRepositoryProvider),
  );
});

class CheckSheetSupportNotifier extends StateNotifier<CheckSheetSupportState> {
  CheckSheetSupportNotifier({
    required this.ref,
    required this.childId,
    required this.checkSheetSupportRepository,
  }) : super(const CheckSheetSupportState.loading()) {
    _fetchList();
  }

  final Ref ref;
  final int? childId;
  final CheckSheetSupportRepository checkSheetSupportRepository;
  final questionCheckOk = SupportQuestionCheckStatus.ok.value;
  final questionCheckNo = SupportQuestionCheckStatus.no.value;

  CheckSheetSupportStateLoaded get _getLoaded =>
      state as CheckSheetSupportStateLoaded;

  Future<void> _fetchList() async {
    if (childId == null) {
      return;
    }

    await checkSheetSupportRepository.fetchDetailList(childId: childId!).then(
      (response) {
        final data = response.data;
        if (response.isFailure || data == null) {
          _showError(response.msg ?? IHSTexts.error);
          return;
        }

        final largeCategoryList = data.largeCategoryList
            .map(CheckSheetSupportLargeCategoryState.fromModel)
            .toList();

        state = CheckSheetSupportState.loaded(
          largeCategoryList: largeCategoryList,
        );
      },
    ).catchError(
      (error) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        }

        _showError(IHSTexts.error);
      },
    );
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }

  /// ????????????????????????????????????/?????????????????????
  void onChangedIsShowOnlyAnswered({required bool value}) {
    final loadedState = _getLoaded;
    state = loadedState.copyWith(isShowOnlyAnswered: value);
  }

  /// ???????????????????????????/?????????
  void onChangedIsShowLargeCategoryArea() {
    final loadedState = _getLoaded;
    final isShowOnlyAnswered = loadedState.isShowOnlyAnswered;

    final newLargeCategoryList =
        loadedState.largeCategoryList.map((largeCategory) {
      final isShowSmallCategoryList = largeCategory.smallCategoryList
          .map((smallCategory) => smallCategory.isShowSmallCategoryArea)
          .toList();
      final isShowLargeCategoryArea = !isShowOnlyAnswered ||
          (isShowOnlyAnswered && isShowSmallCategoryList.contains(true));

      return largeCategory.copyWith(
        isShowLargeCategoryArea: isShowLargeCategoryArea,
      );
    }).toList();

    state = loadedState.copyWith(largeCategoryList: newLargeCategoryList);
  }

  /// ???????????????????????????/?????????
  void onChangedIsShowSmallCategoryArea() {
    final loadedState = _getLoaded;
    final isShowOnlyAnswered = loadedState.isShowOnlyAnswered;

    final newLargeCategoryList =
        loadedState.largeCategoryList.map((largeCategory) {
      final newSmallCategoryList =
          largeCategory.smallCategoryList.map((smallCategory) {
        final checkList = smallCategory.questionList
            .map((question) => question.isCheck)
            .toList();
        final isShowSmallCategoryArea = !isShowOnlyAnswered ||
            (isShowOnlyAnswered && checkList.contains(questionCheckOk));

        return smallCategory.copyWith(
          isShowSmallCategoryArea: isShowSmallCategoryArea,
        );
      }).toList();

      return largeCategory.copyWith(smallCategoryList: newSmallCategoryList);
    }).toList();

    state = loadedState.copyWith(largeCategoryList: newLargeCategoryList);
  }

  /// ???????????????/?????????
  void onChangedIsShowQuestionArea() {
    final loadedState = _getLoaded;
    final isShowOnlyAnswered = loadedState.isShowOnlyAnswered;

    final newLargeCategoryList =
        loadedState.largeCategoryList.map((largeCategory) {
      final newSmallCategoryList =
          largeCategory.smallCategoryList.map((smallcategory) {
        final newQuestionList = smallcategory.questionList.map((question) {
          final isShowQuestionArea = !isShowOnlyAnswered ||
              (questionCheckOk == question.isCheck && isShowOnlyAnswered);

          return question.copyWith(isShowQuestionArea: isShowQuestionArea);
        }).toList();

        return smallcategory.copyWith(questionList: newQuestionList);
      }).toList();

      return largeCategory.copyWith(smallCategoryList: newSmallCategoryList);
    }).toList();

    state = loadedState.copyWith(largeCategoryList: newLargeCategoryList);
  }

  /// ??????????????????????????????????????????
  void onTapCheck({
    required int largeCategoryId,
    required int smallCategoryId,
    required int questionId,
  }) {
    final loadedState = _getLoaded;
    final largeCategory = loadedState.largeCategoryList.firstWhere(
      (largeCategory) => largeCategory.id == largeCategoryId,
    );
    final smallCategory = largeCategory.smallCategoryList.firstWhere(
      (smallCategory) => smallCategory.id == smallCategoryId,
    );

    final newQuestionList = smallCategory.questionList.map((question) {
      return question.questionId == questionId
          ? question.copyWith(
              isCheck: questionCheckNo == question.isCheck
                  ? questionCheckOk
                  : questionCheckNo)
          : question;
    }).toList();

    final newSmallCategoryList = largeCategory.smallCategoryList.map(
      (sCategory) {
        return sCategory.id == smallCategoryId
            ? sCategory.copyWith(questionList: newQuestionList)
            : sCategory;
      },
    ).toList();

    final newLargeCategoryList = loadedState.largeCategoryList.map(
      (lCategory) {
        return lCategory.id == largeCategoryId
            ? lCategory.copyWith(smallCategoryList: newSmallCategoryList)
            : lCategory;
      },
    ).toList();

    state = loadedState.copyWith(largeCategoryList: newLargeCategoryList);
  }

  /// ??????
  Future<void> onTapSave({
    required Function() onSuccess,
    required Function(String msg) onFailure,
  }) async {
    final request = _setRequest();
    await checkSheetSupportRepository.save(request: request).then(
      (response) {
        if (response.isFailure) {
          _showError(response.msg ?? IHSTexts.error);
          return;
        }

        onSuccess();
      },
    ).catchError(
      (error) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        }

        onFailure(IHSTexts.error);
      },
    );
  }

  CheckSheetSupportSaveRequest _setRequest() {
    final answeredList = <SupportQuestionState>[];
    _getLoaded.largeCategoryList.forEach((largeCategory) {
      largeCategory.smallCategoryList.forEach((smallcategory) {
        answeredList.addAll(smallcategory.questionList);
      });
    });

    return CheckSheetSupportSaveRequest(
      childId: childId!,
      answerList: answeredList.map((e) {
        return SupportQustionAnswerRequest(
          supportCheckSheetId: e.id,
          supportCheckSheetQuestionId: e.questionId,
          isCheck: e.isCheck,
          note: e.noteController.text,
        );
      }).toList(),
    );
  }
}
