import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/model/response/model.dart';
import '../../../data/repository/child.dart';
import '../../../data/request/child_delete/request.dart';
import '../../../data/request/child_save/request.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../type/gender.dart';
import '../../component/child_list_item/state.dart';
import '../child_book_select/notifier.dart';
import 'state.dart';

/// お子さま情報の入力の状態を管理するプロバイダー
final childInputStateProvider =
    AutoDisposeStateNotifierProvider<ChildEditNotifier, ChildEditState>((ref) {
  return ChildEditNotifier(
    ref: ref,
    repository: ref.watch(childRepositoryProvider),
  );
});

class ChildEditNotifier extends StateNotifier<ChildEditState> {
  ChildEditNotifier({
    required this.ref,
    required this.repository,
  }) : super(const ChildEditState());

  final AutoDisposeStateNotifierProviderRef ref;
  final ChildRepository repository;

  void setup(ChildListItemDataChild item) {
    state = state.copyWith(
      inputData: ChildEditData(
        name: item.name,
        gender: item.gender,
        birthday: item.birthday,
      ),
    );
  }

  // 名前（ニックネーム）
  void onChangedNameField(String name) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        name: name,
      ),
    );
  }

  // 性別
  void onChangedGender(Gender gender) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        gender: gender,
      ),
    );
  }

  // 出産予定日
  void onChangedDateField(DateTime? birthday) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        birthday: birthday,
      ),
    );
  }

// 登録(更新)
  void onTapRegister({
    int? childId,
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final inputData = state.inputData;
    if (inputData.name.isEmpty ||
        inputData.gender == null ||
        inputData.birthday == null) {
      onFailure('未入力の項目があります');
      return;
    }

    if (state.saving) {
      return;
    }
    state = state.copyWith(saving: true);

    final request = ChildSaveRequest(
      childId: childId,
      nickname: state.inputData.name,
      gender: state.inputData.gender!.num,
      birthday: state.inputData.birthday.toString(),
    );

    repository.saveChild(request: request).then(
      (response) {
        state = state.copyWith(saving: false);

        if (response.status == ResponseStatus.failure) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        // 子ども一覧の更新を依頼
        ref.read(childListStatusProvider.notifier).fetch();
        onSuccess();
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        } else {
          onFailure('予期せぬエラーが発生しました');
        }
      },
    );
  }

  // 削除
  void onTapDelete({
    int? childId,
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    if (state.saving) {
      return;
    }

    state = state.copyWith(saving: true);

    final request = ChildDeleteRequest(childId: childId!);

    repository.deleteChild(request: request).then(
      (response) {
        state = state.copyWith(saving: false);

        if (response.status == ResponseStatus.failure) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        // 子ども一覧の更新を依頼
        ref.read(childListStatusProvider.notifier).fetch();
        onSuccess();
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        } else {
          onFailure('予期せぬエラーが発生しました');
        }
      },
    );
  }
}
