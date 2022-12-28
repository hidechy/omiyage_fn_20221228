import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/model/response/model.dart';
import '/data/repository/baby.dart';
import '/data/request/baby_save/request.dart';
import '../../../data/http/exception/exception.dart';
import '../../../data/request/baby_delete/request.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import '../child_book_select/notifier.dart';
import '../../component/child_list_item/state.dart';
import 'state.dart';

/// 胎児情報の入力の状態を管理するプロバイダー
final babyInputStateProvider =
    AutoDisposeStateNotifierProvider<BabyEditNotifier, BabyEditState>((ref) {
  return BabyEditNotifier(
    ref: ref,
    repository: ref.watch(babyRepositoryProvider),
  );
});

class BabyEditNotifier extends StateNotifier<BabyEditState> {
  BabyEditNotifier({
    required this.ref,
    required this.repository,
  }) : super(const BabyEditState());

  final AutoDisposeStateNotifierProviderRef ref;
  final BabyRepository repository;

  void setup(ChildListItemDataBaby babyItem) {
    state = state.copyWith(
      inputData: BabyEditData(
        name: babyItem.name,
        scheduledBirthday: babyItem.scheduledBirthday,
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

  // 出産予定日
  void onChangedDateField(DateTime? scheduledBirthday) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        scheduledBirthday: scheduledBirthday,
      ),
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

    final request = BabyDeleteRequest(childId: childId!);

    repository.deleteBaby(request: request).then(
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

  // 登録(更新)
  void onTapRegister({
    int? childId,
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final inputData = state.inputData;
    if (inputData.name.isEmpty || inputData.scheduledBirthday == null) {
      onFailure('未入力の項目があります');
      return;
    }

    if (state.saving) {
      return;
    }
    state = state.copyWith(saving: true);

    final request = BabySaveRequest(
      childId: childId,
      nickname: state.inputData.name,
      birthScheduleDate: state.inputData.scheduledBirthday.toString(),
    );

    repository.saveBaby(request: request).then(
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
        }
        IHSUtil.showSnackBar(msg: '予期せぬエラーが発生しました');
      },
    );
  }
}
