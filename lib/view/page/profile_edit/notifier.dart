import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/model/response/model.dart';
import '../../../data/repository/profile.dart';
import '../../../data/request/profile_edit/request.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../type/gender.dart';
import '../profile_info/notifier.dart';
import '../profile_info/state.dart';
import 'state.dart';

/// プロフィール情報の入力の状態を管理するプロバイダー
final profileEditStateProvider = AutoDisposeStateNotifierProvider.family<
    ProfileEditNotifier, ProfileEditState, ProfileInfoData>((ref, profile) {
  return ProfileEditNotifier(
    ref: ref,
    profileInfoData: profile,
    repository: ref.watch(profileRepositoryProvider),
  );
});

class ProfileEditNotifier extends StateNotifier<ProfileEditState> {
  ProfileEditNotifier({
    required this.ref,
    required this.profileInfoData,
    required this.repository,
  }) : super(const ProfileEditState()) {
    setup(profileInfoData);
  }

  final AutoDisposeStateNotifierProviderRef<ProfileEditNotifier,
      ProfileEditState> ref;

  final ProfileInfoData profileInfoData;
  final ProfileRepository repository;

  void setup(ProfileInfoData inputData) {
    state = state.copyWith(
      inputData: inputData,
    );
  }

  // 名前（ニックネーム）
  void onChangedNameField(String name) {
    state = state.copyWith(
      inputData: state.inputData!.copyWith(
        name: name,
      ),
    );
  }

  // 生年月日
  void onChangedDateField(DateTime? birthday) {
    state = state.copyWith(
      inputData: state.inputData!.copyWith(
        birthday: birthday,
      ),
    );
  }

  // 性別
  void onChangedGenderField(Gender gender) {
    state = state.copyWith(
      inputData: state.inputData!.copyWith(
        gender: gender,
      ),
    );
  }

  // 郵便番号
  void onChangedPostalCodeField(String postalCode) {
    state = state.copyWith(
      inputData: state.inputData!.copyWith(
        postalCode: postalCode,
      ),
    );
  }

  // 登録
  void onTapRegister({
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    if (state.saving) {
      return;
    }

    state = state.copyWith(saving: true);

    //name, postalCode, (email)はstateにて初期値設定されている
    final request = ProfileEditRequest(
      nickname: state.inputData!.name,
      birthday: state.inputData!.birthday == null
          ? ''
          : state.inputData!.birthday.toString(),
      gender: state.inputData!.gender.num,
      postalCode: state.inputData!.postalCode,
    );

    repository.editProfile(request: request).then(
      (response) {
        state = state.copyWith(saving: false);

        if (response.status == ResponseStatus.failure) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        // プロフィールの更新を依頼
        ref.read(profileInfoStateProvider.notifier).fetchProfile();

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
