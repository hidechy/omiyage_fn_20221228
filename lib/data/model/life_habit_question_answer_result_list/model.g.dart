// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LifeHabitQuestionAnswerResultListModel
    _$$_LifeHabitQuestionAnswerResultListModelFromJson(
            Map<String, dynamic> json) =>
        _$_LifeHabitQuestionAnswerResultListModel(
          list: (json['results'] as List<dynamic>)
              .map((e) =>
                  QuestionAnswerResultModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          generalComment: GeneralCommentModel.fromJson(
              json['general_comments'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_LifeHabitQuestionAnswerResultListModelToJson(
        _$_LifeHabitQuestionAnswerResultListModel instance) =>
    <String, dynamic>{
      'results': instance.list,
      'general_comments': instance.generalComment,
    };

_$_QuestionAnswerResultModel _$$_QuestionAnswerResultModelFromJson(
        Map<String, dynamic> json) =>
    _$_QuestionAnswerResultModel(
      id: json['question_id'] as int,
      title: json['title'] as String,
      hint: json['hint'] as String? ?? '',
      content: json['question'] as String,
      answer: json['answer'] as int,
      point: json['point'] as int,
      comment: json['comment'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QuestionAnswerResultModelToJson(
        _$_QuestionAnswerResultModel instance) =>
    <String, dynamic>{
      'question_id': instance.id,
      'title': instance.title,
      'hint': instance.hint,
      'question': instance.content,
      'answer': instance.answer,
      'point': instance.point,
      'comment': instance.comment,
      'choices': instance.choices,
    };

_$_ChoiceModel _$$_ChoiceModelFromJson(Map<String, dynamic> json) =>
    _$_ChoiceModel(
      id: json['choice_id'] as int,
      content: json['choice'] as String,
    );

Map<String, dynamic> _$$_ChoiceModelToJson(_$_ChoiceModel instance) =>
    <String, dynamic>{
      'choice_id': instance.id,
      'choice': instance.content,
    };

_$_GeneralCommentModel _$$_GeneralCommentModelFromJson(
        Map<String, dynamic> json) =>
    _$_GeneralCommentModel(
      perfectComment: json['perfect_comment'] as String,
      categoryList: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GeneralCommentModelToJson(
        _$_GeneralCommentModel instance) =>
    <String, dynamic>{
      'perfect_comment': instance.perfectComment,
      'categories': instance.categoryList,
    };

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      id: json['category_id'] as int,
      name: json['category_name'] as String,
      commentList: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.id,
      'category_name': instance.name,
      'comments': instance.commentList,
    };

_$_CommentModel _$$_CommentModelFromJson(Map<String, dynamic> json) =>
    _$_CommentModel(
      content: json['comment'] as String,
    );

Map<String, dynamic> _$$_CommentModelToJson(_$_CommentModel instance) =>
    <String, dynamic>{
      'comment': instance.content,
    };
