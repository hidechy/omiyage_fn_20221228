import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/model/response/model.dart';
import '/data/repository/auth.dart';
import '/data/repository/common.dart';
import '../../../data/http/exception/exception.dart';
import '../../../data/local/local_client.dart';
import '../../../data/model/code_publish/model.dart';
import '../../../provider/maintenance/notifier.dart';
import 'state.dart';

/// パスワードリセットの入力の状態を管理するプロバイダー
final passwordResetStateProvider =
    AutoDisposeStateNotifierProvider<PasswordResetNotifier, PasswordResetState>(
        (ref) {
  return PasswordResetNotifier(
    ref: ref,
    localClient: ref.watch(localClientProvider),
    authRepository: ref.watch(authRepositoryProvider),
    commonRepository: ref.watch(commonRepositoryProvider),
  );
});

class PasswordResetNotifier extends StateNotifier<PasswordResetState> {
  PasswordResetNotifier({
    required this.ref,
    required this.localClient,
    required this.authRepository,
    required this.commonRepository,
  }) : super(const PasswordResetState());

  final AutoDisposeStateNotifierProviderRef<PasswordResetNotifier, PasswordResetState>
      ref;
  final AuthRepository authRepository;
  final CommonRepository commonRepository;
  final LocalClient localClient;

  // メールアドレス
  void onChangedEmail(String email) {
    state = state.copyWith(
      email: email,
    );
  }

  void onTapRegister({
    required VoidCallback onSuccess,
    required Function(String) onFailure,
  }) {
    if (state.saving) {
      return;
    }

    state = state.copyWith(saving: true);

    if (state.email.isEmpty) {
      // バリデーションを実施しているため通らない想定
      onFailure('未入力の項目があります');
      state = state.copyWith(saving: false);
      return;
    }
    authRepository.codePublishForPasswordChange(email: state.email).then(
      (IHSResponse<CodePublishModel> response) {
        state = state.copyWith(saving: false);

        final model = response.data;
        if (response.status == ResponseStatus.failure || model == null) {
          onFailure(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }
        onSuccess();
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        onFailure('予期せぬエラーが発生しました');
      },
    );
  }
}
