import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/signup/notifier.dart';
import 'state.dart';

/// 胎児情報の入力の状態を管理するプロバイダー
final babyInputStateProvider =
    AutoDisposeStateNotifierProvider<BabyInputNotifier, BabyInputState>((ref) {
  return BabyInputNotifier(ref: ref);
});

class BabyInputNotifier extends StateNotifier<BabyInputState> {
  BabyInputNotifier({
    required this.ref,
  }) : super(const BabyInputState());

  final AutoDisposeStateNotifierProviderRef ref;

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

  // 登録
  void onTapRegister({
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final inputData = state.inputData;
    if (inputData.name.isEmpty || inputData.scheduledBirthday == null) {
      onFailure('未入力の項目があります');
      return;
    }

    // トップレベルのstateを更新
    ref.read(signUpStateProvider.notifier).onInputBabyInfo(
          nickname: inputData.name,
          birthScheduledDate: inputData.scheduledBirthday.toString(),
        );

    if (state.saving) {
      return;
    }
    state = state.copyWith(saving: true);

    ref.read(signUpStateProvider.notifier).signUp(
      onSuccess: () {
        state = state.copyWith(saving: false);
        ref.read(signUpStateProvider.notifier).reset();
        onSuccess();
      },
      onFailure: (msg) {
        state = state.copyWith(saving: false);
        onFailure(msg);
      },
    );
  }
}
