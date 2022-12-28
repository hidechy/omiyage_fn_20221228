import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../type/gender.dart';
import '/provider/signup/notifier.dart';
import 'state.dart';

/// プロフィール情報の入力の状態を管理するプロバイダー
final profileInputStateProvider =
    AutoDisposeStateNotifierProvider<ProfileInputNotifier, ProfileInputState>(
  (ref) {
    return ProfileInputNotifier(ref: ref);
  },
);

class ProfileInputNotifier extends StateNotifier<ProfileInputState> {
  ProfileInputNotifier({
    required this.ref,
  }) : super(const ProfileInputState());
  final AutoDisposeStateNotifierProviderRef ref;

  // 名前（ニックネーム）
  void onChangedNameField(String name) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        name: name,
      ),
    );
  }

  // 生年月日
  void onChangedDateField(DateTime? birthday) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        birthday: birthday,
      ),
    );
  }

  // 性別
  void onChangedGenderField(Gender gender) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        gender: gender,
      ),
    );
  }

  // 郵便番号
  void onChangedPostalCodeField(String postalCode) {
    state = state.copyWith(
      inputData: state.inputData.copyWith(
        postalCode: postalCode,
      ),
    );
  }

  // プロフィール登録
  void onTapRegister({
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    final inputData = state.inputData;
    if (inputData.name.isEmpty ||
        inputData.birthday == null ||
        inputData.postalCode.isEmpty) {
      onFailure('未入力の項目があります');
      return;
    }

    // トップレベルのstateを更新
    ref.read(signUpStateProvider.notifier).onInputProfile(
          nickname: inputData.name,
          birthday: inputData.birthday.toString(),
          gender: inputData.gender.num,
          postalCode: inputData.postalCode.replaceAll('-', ''),
        );
    onSuccess();
  }
}
