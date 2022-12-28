import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

/// 生活習慣設問回答結果取得から返却されるデータモデル
@freezed
class LifeHabitQuestionAnswerResultListModel
    with _$LifeHabitQuestionAnswerResultListModel {
  const factory LifeHabitQuestionAnswerResultListModel({
    @JsonKey(name: 'results') required List<QuestionAnswerResultModel> list,
    @JsonKey(name: 'general_comments')
        required GeneralCommentModel generalComment,
  }) = _LifeHabitQuestionAnswerResultListModel;

  factory LifeHabitQuestionAnswerResultListModel.fromJson(
          Map<String, dynamic> json) =>
      _$LifeHabitQuestionAnswerResultListModelFromJson(json);
}

@freezed
class QuestionAnswerResultModel with _$QuestionAnswerResultModel {
  const factory QuestionAnswerResultModel({
    @JsonKey(name: 'question_id') required int id,
    @JsonKey(name: 'title') required String title,
    @Default('') @JsonKey(name: 'hint') String hint,
    @JsonKey(name: 'question') required String content,
    @JsonKey(name: 'answer') required int answer,
    @JsonKey(name: 'point') required int point,
    @JsonKey(name: 'comment') required String comment,
    @JsonKey(name: 'choices') required List<ChoiceModel> choices,
  }) = _QuestionAnswerResultModel;

  factory QuestionAnswerResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerResultModelFromJson(json);
}

@freezed
class ChoiceModel with _$ChoiceModel {
  const factory ChoiceModel({
    @JsonKey(name: 'choice_id') required int id,
    @JsonKey(name: 'choice') required String content,
  }) = _ChoiceModel;

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);
}

@freezed
class GeneralCommentModel with _$GeneralCommentModel {
  const factory GeneralCommentModel({
    @JsonKey(name: 'perfect_comment') required String perfectComment,
    @JsonKey(name: 'categories') required List<CategoryModel> categoryList,
  }) = _GeneralCommentModel;

  factory GeneralCommentModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralCommentModelFromJson(json);
}

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @JsonKey(name: 'category_id') required int id,
    @JsonKey(name: 'category_name') required String name,
    @JsonKey(name: 'comments') required List<CommentModel> commentList,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    @JsonKey(name: 'comment') required String content,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
