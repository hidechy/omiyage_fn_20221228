import 'dart:developer';

import 'package:family_notes/data/http/exception/exception.dart';
import 'package:family_notes/data/model/response/model.dart';
import 'package:family_notes/data/repository/life_habit_repository.dart';
import 'package:family_notes/data/request/life_habit_question_save/request.dart';
import 'package:family_notes/provider/user/notifier.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import 'state.dart';

/// 生活習慣設問プロバイダー
final lifeHabitQuestionStateProvider = AutoDisposeStateNotifierProvider<
    LifeHabitQuestionStateNotifier, LifeHabitQuestionState>((ref) {
  final childId = ref
      .watch(userStateProvider)
      .mapOrNull(authenticated: (value) => value.selectedChildId);

  return LifeHabitQuestionStateNotifier(
    ref: ref,
    childId: childId,
    lifeHabitRepository: ref.watch(lifeHabitRepositoryProvider),
  );
});

class LifeHabitQuestionStateNotifier
    extends StateNotifier<LifeHabitQuestionState> {
  LifeHabitQuestionStateNotifier({
    required this.ref,
    required this.childId,
    required this.lifeHabitRepository,
  }) : super(const LifeHabitQuestionState.loading()) {
    _fetchList();
  }

  final Ref ref;
  final int? childId;
  final LifeHabitRepository lifeHabitRepository;

  /// 生活習慣設問取得
  Future<void> _fetchList() async {
    if (childId == null) {
      _showError(IHSTexts.error);
      return;
    }

    await lifeHabitRepository
        .fetchQuestionList(childId: childId!)
        .then((response) {
      final data = response.data;
      if (ResponseStatus.failure == response.status || data == null) {
        _showError(response.msg ?? IHSTexts.error);
        return;
      }

      final list = data.list.map((e) {
        return QuestionState.fromModel(e);
      }).toList();

      state = LifeHabitQuestionState.loaded(list: list);

      /// 画面初期描画時に最初の設問の未回答選択肢idを状態として保持するため
      final firstQuestionNoAnswerChoiceId = list.first.choices
          .firstWhere((element) => element.content.isEmpty)
          .id;

      _setInitialAnswerChoiceId(firstQuestionNoAnswerChoiceId);
    }).catchError((error) {
      if (error is MaintenanceModeHttpStatusException) {
        ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        return;
      }

      _showError(IHSTexts.error);
    });
  }

  /// 最初の設問の未回答選択肢idを状態として保持
  void _setInitialAnswerChoiceId(int firstQuestionNoAnswerChoiceId) {
    final loadedState = _setLoaded();
    state = loadedState.copyWith(
      inputData: loadedState.inputData.copyWith(
        currentChoiceId: firstQuestionNoAnswerChoiceId,
      ),
    );
  }

  /// 次の設問番号の保持
  void moveNextQuestion() {
    final loadedState = _setLoaded();
    final currentIndex = loadedState.inputData.currentQuestionIndex;
    state = loadedState.copyWith(
      inputData: loadedState.inputData.copyWith(
        currentQuestionIndex: currentIndex + 1,
      ),
    );
  }

  /// 設問選択肢idの保持
  void onChangedCurrentChoiceId(int id) {
    final loadedState = _setLoaded();
    state = loadedState.copyWith(
      inputData: loadedState.inputData.copyWith(
        currentChoiceId: id,
      ),
    );
  }

  /// 次の設問移動時に回答状態を未回答状態とするため、設問の未回答に該当するchoiceIdを保持
  void setNextQuestionNoAnswerChoiceId(List<QuestionState> questions) {
    final loadedState = _setLoaded();
    final nextQuestion = questions[loadedState.inputData.currentQuestionIndex];
    // 未回答状態を表すchoiceIdの取得
    final nextQuestionNoAnswerChoiceId = nextQuestion.choices
        .firstWhere((element) => element.content.isEmpty)
        .id;
    state = loadedState.copyWith(
      inputData: loadedState.inputData.copyWith(
        currentChoiceId: nextQuestionNoAnswerChoiceId,
      ),
    );
  }

  /// 回答内容の保持
  void setAnswer({required int questionId}) {
    final loadedState = _setLoaded();
    final answer = AnswerState(
      questionId: questionId,
      choiceId: loadedState.inputData.currentChoiceId,
    );
    final answers = [answer, ...loadedState.inputData.answers];
    state = loadedState.copyWith(
      inputData: loadedState.inputData.copyWith(
        answers: answers,
      ),
    );
  }

  /// 保存
  Future<void> onTapSave({
    required Function(int) onSuccess,
    required Function(String) onFailure,
  }) async {
    final loadedState = _setLoaded();
    if (loadedState.saving) {
      return;
    }

    state = loadedState.copyWith(saving: true);
    log(loadedState.mapOrNull(loaded: (value) => value.inputData).toString());
    final request = _setRequest(loadedState);

    await lifeHabitRepository.save(request: request).then((response) {
      state = loadedState.copyWith(saving: false);
      final data = response.data;
      if (response.status == ResponseStatus.failure || data == null) {
        onFailure(response.msg ?? IHSTexts.error);
        return;
      }

      final answerHeaderId = data.answerHeaderId;
      onSuccess(answerHeaderId);
    }).catchError((error) {
      state = loadedState.copyWith(saving: false);
      if (error is MaintenanceModeHttpStatusException) {
        ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        return;
      }

      onFailure(IHSTexts.error);
    });
  }

  /// リクエストの保持
  LifeHabitQuestionSaveRequest _setRequest(
    LifeHabitQuestionStateLoaded loadedState,
  ) {
    final answers = loadedState.inputData.answers
        .map((e) {
          return AnswerRequest(
            questionId: e.questionId,
            choiceId: e.choiceId,
          );
        })
        .toList()
        .reversed
        .toList();

    return LifeHabitQuestionSaveRequest(
      childId: childId!,
      answers: answers,
    );
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }

  LifeHabitQuestionStateLoaded _setLoaded() {
    return state as LifeHabitQuestionStateLoaded;
  }
}
