import 'package:family_notes/data/model/life_habit_question_answer_result_list/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../life_habit_question/question_type.dart';
import 'answer_point.dart';

part 'state.freezed.dart';

@freezed
class LifeHabitQuestionResultState with _$LifeHabitQuestionResultState {
  const factory LifeHabitQuestionResultState.loading() =
      LifeHabitQuestionResultStateLoading;

  const factory LifeHabitQuestionResultState.loaded({
    required List<QuestionAnswerResultState> list,
    required GeneralCommentState generalComment,
  }) = LifeHabitQuestionResultStateLoaded;
}

@freezed
class QuestionAnswerResultState with _$QuestionAnswerResultState {
  const factory QuestionAnswerResultState({
    required String title,
    required String content,
    required int id,
    required String hint,
    required int answer,
    required int point,
    required String comment,
    required List<ChoiceState> choices,
    required String assetName,
    required String pointAssetName,
  }) = _QuestionAnswerResultState;

  factory QuestionAnswerResultState.fromModel(QuestionAnswerResultModel model) {
    final assetName = QuestionType.values
        .firstWhere((element) => element.id == model.id)
        .assetName;
    final pointAssetName = AnswerPoint.values
        .firstWhere((element) => element.value == model.point)
        .assetName;

    return QuestionAnswerResultState(
      title: model.title,
      content: model.content,
      id: model.id,
      hint: model.hint,
      answer: model.answer,
      point: model.point,
      comment: model.comment,
      assetName: assetName,
      pointAssetName: pointAssetName,
      choices: model.choices.map(ChoiceState.fromModel).toList(),
    );
  }
}

@freezed
class ChoiceState with _$ChoiceState {
  const factory ChoiceState({
    required int id,
    required String content,
  }) = _ChoiceState;

  factory ChoiceState.fromModel(ChoiceModel model) {
    final content = model.content == '不明' ? '' : model.content;

    return ChoiceState(
      id: model.id,
      content: content,
    );
  }
}

@freezed
class GeneralCommentState with _$GeneralCommentState {
  const factory GeneralCommentState({
    @JsonKey(name: 'perfect_comment') required String perfectComment,
    @JsonKey(name: 'categories') required List<CategoryState> categoryList,
  }) = _GeneralCommentState;

  factory GeneralCommentState.fromModel(GeneralCommentModel model) {
    return GeneralCommentState(
      perfectComment: model.perfectComment,
      categoryList: model.categoryList.map(CategoryState.fromModel).toList(),
    );
  }
}

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @JsonKey(name: 'category_id') required int id,
    @JsonKey(name: 'category_name') required String name,
    @JsonKey(name: 'comments') required List<CommentState> commentList,
  }) = _CategoryState;

  factory CategoryState.fromModel(CategoryModel model) {
    return CategoryState(
      id: model.id,
      name: model.name,
      commentList: model.commentList.map(CommentState.fromModel).toList(),
    );
  }
}

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @JsonKey(name: 'comment') required String content,
  }) = _CommentState;

  factory CommentState.fromModel(CommentModel model) {
    return CommentState(content: model.content);
  }
}
