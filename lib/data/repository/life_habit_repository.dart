import 'package:family_notes/data/http/client.dart';
import 'package:family_notes/data/model/life_habit_question_answer_history_list/model.dart';
import 'package:family_notes/data/model/life_habit_question_answer_result_list/model.dart';
import 'package:family_notes/data/model/life_habit_question_answer_save/model.dart';
import 'package:family_notes/data/model/life_habit_question_list/model.dart';
import 'package:family_notes/data/model/response/model.dart';
import 'package:family_notes/data/request/life_habit_question_save/request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../http/path.dart';

final lifeHabitRepositoryProvider = Provider<LifeHabitRepositoryImpl>((ref) {
  final client = ref.read(httpClientProvider);
  return LifeHabitRepositoryImpl(client);
});

/// 生活習慣関連Repository
abstract class LifeHabitRepository {
  /// 生活習慣設問取得
  Future<IHSResponse<LifeHabitQuestionListModel>> fetchQuestionList({
    required int childId,
  });

  /// 生活習慣設問回答保存
  Future<IHSResponse<LifeHabitQuestionAnswerSaveModel>> save({
    required LifeHabitQuestionSaveRequest request,
  });

  /// 生活習慣設問回答結果取得
  Future<IHSResponse<LifeHabitQuestionAnswerResultListModel>>
      fetchAnswerResultList({
    required int childId,
    required int answerHeaderId,
  });

  /// 生活習慣設問回答履歴取得
  Future<IHSResponse<LifeHabitQuestionAnswerHistoryListModel>>
      fetchAnswerHistoryList({
    required int childId,
  });
}

class LifeHabitRepositoryImpl implements LifeHabitRepository {
  LifeHabitRepositoryImpl(this.client);

  final IHSHttpClient client;

  @override
  Future<IHSResponse<LifeHabitQuestionListModel>> fetchQuestionList({
    required int childId,
  }) async {
    final response = await client.post(
      IHSAPIPath.lifeHabitCheckupCheckSheetGetQuestions,
      body: {'child_id': childId},
    );

    return IHSResponse<LifeHabitQuestionListModel>.fromJson(
      response,
      (json) {
        if (response['data'] == null) {
          return null;
        }

        return LifeHabitQuestionListModel.fromJson(
          json! as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<IHSResponse<LifeHabitQuestionAnswerSaveModel>> save({
    required LifeHabitQuestionSaveRequest request,
  }) async {
    final response = await client.post(
      IHSAPIPath.lifeHabitCheckupCheckSheetSave,
      body: request.toJson(),
    );

    return IHSResponse<LifeHabitQuestionAnswerSaveModel>.fromJson(response,
        (Object? json) {
      if (response['data'] == null) {
        return null;
      }

      return LifeHabitQuestionAnswerSaveModel.fromJson(
        json! as Map<String, dynamic>,
      );
    });
  }

  @override
  Future<IHSResponse<LifeHabitQuestionAnswerResultListModel>>
      fetchAnswerResultList({
    required int childId,
    required int answerHeaderId,
  }) async {
    final response = await client.post(
      IHSAPIPath.lifeHabitCheckupCheckSheetGetResult,
      body: {
        'child_id': childId,
        'answer_headers_id': answerHeaderId,
      },
    );

    return IHSResponse<LifeHabitQuestionAnswerResultListModel>.fromJson(
      response,
      (json) {
        if (response['data'] == null) {
          return null;
        }

        return LifeHabitQuestionAnswerResultListModel.fromJson(
          json! as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<IHSResponse<LifeHabitQuestionAnswerHistoryListModel>>
      fetchAnswerHistoryList({
    required int childId,
  }) async {
    final response = await client.post(
      IHSAPIPath.lifeHabitCheckupCheckSheetGetHistory,
      body: {'child_id': childId},
    );

    return IHSResponse<LifeHabitQuestionAnswerHistoryListModel>.fromJson(
      response,
      (json) {
        if (response['data'] == null) {
          return null;
        }

        return LifeHabitQuestionAnswerHistoryListModel.fromJson(
          json! as Map<String, dynamic>,
        );
      },
    );
  }
}
