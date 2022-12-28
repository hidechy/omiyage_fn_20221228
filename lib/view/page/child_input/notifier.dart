import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/signup/notifier.dart';
import '../../../type/gender.dart';
import 'state.dart';

/// お子さま情報の入力の状態を管理するプロバイダー
final childInputStateProvider =
    AutoDisposeStateNotifierProvider<ChildInputNotifier, ChildInputState>(
        (ref) {
  return ChildInputNotifier(ref: ref);
});

class ChildInputNotifier extends StateNotifier<ChildInputState> {
  ChildInputNotifier({
    required this.ref,
  }) : super(const ChildInputState());

  final AutoDisposeStateNotifierProviderRef ref;

  void setup(ChildInputData inputData) {
    state = state.copyWith(
      inputData: inputData,
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

  // 登録
  void onTapRegister({
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

    // トップレベルのstateを更新
    ref.read(signUpStateProvider.notifier).onInputChildInfo(
          nickname: inputData.name,
          gender: inputData.gender!.num,
          birthday: inputData.birthday.toString(),
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

  void onTapCancel() {
    ref.read(signUpStateProvider.notifier).resetChildInfo();
  }
}
