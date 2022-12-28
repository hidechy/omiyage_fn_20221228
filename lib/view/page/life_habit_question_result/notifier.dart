import 'package:family_notes/data/model/response/model.dart';
import 'package:family_notes/data/repository/life_habit_repository.dart';
import 'package:family_notes/provider/user/notifier.dart';
import 'package:family_notes/view/page/life_habit_question_result/state.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';

/// 設問回答結果画面状態プロバイダー
final lifeHabitQuestionResultStateProvider =
    AutoDisposeStateNotifierProvider.family<
        LifeHabitQuestionResultStateNotifier,
        LifeHabitQuestionResultState,
        int>((ref, answerHeaderId) {
  final childId = ref
      .watch(userStateProvider)
      .mapOrNull(authenticated: (value) => value.selectedChildId);

  return LifeHabitQuestionResultStateNotifier(
    answerHeaderid: answerHeaderId,
    childId: childId,
    ref: ref,
    lifeHabitRepository: ref.watch(lifeHabitRepositoryProvider),
  );
});

class LifeHabitQuestionResultStateNotifier
    extends StateNotifier<LifeHabitQuestionResultState> {
  LifeHabitQuestionResultStateNotifier({
    required int answerHeaderid,
    required this.childId,
    required this.ref,
    required this.lifeHabitRepository,
  }) : super(const LifeHabitQuestionResultState.loading()) {
    _fetchList(answerHeaderid);
  }

  final int? childId;
  final Ref ref;
  final LifeHabitRepository lifeHabitRepository;

  /// 設問回答結果取得
  Future<void> _fetchList(int answerHeaderId) async {
    if (childId == null) {
      return;
    }

    await lifeHabitRepository
        .fetchAnswerResultList(
      childId: childId!,
      answerHeaderId: answerHeaderId,
    )
        .then((response) {
      final data = response.data;

      if (ResponseStatus.failure == response.status || data == null) {
        _showError(response.msg ?? IHSTexts.error);
        return;
      }

      final list = data.list.map((e) {
        return QuestionAnswerResultState.fromModel(e);
      }).toList();
      final generalComment = GeneralCommentState.fromModel(
        data.generalComment,
      );

      state = LifeHabitQuestionResultState.loaded(
        list: list,
        generalComment: generalComment,
      );
    }).catchError((error) {
      if (error is MaintenanceModeHttpStatusException) {
        ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        return;
      }

      _showError(IHSTexts.error);
    });
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
