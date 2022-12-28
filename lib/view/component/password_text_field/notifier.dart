import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifier.freezed.dart';

@freezed
class PasswordTextFieldeState with _$PasswordTextFieldeState {
  factory PasswordTextFieldeState({
    // パスワードの表示
    required bool visiblePassword,
  }) = _PasswordTextFieldeState;
}

/// パスワードのテキストフィールドの状態を管理するプロバイダ
final passwordTextFieldStateProvider = AutoDisposeStateNotifierProvider.family<
    PasswordTextFieldeStateNotifier, PasswordTextFieldeState, String>((ref, key) {
  return PasswordTextFieldeStateNotifier();
});

class PasswordTextFieldeStateNotifier
    extends StateNotifier<PasswordTextFieldeState> {
  PasswordTextFieldeStateNotifier()
      : super(PasswordTextFieldeState(
          visiblePassword: false,
        ));

  void setVisiblePassword({
    required bool active,
  }) {
    state = state.copyWith(visiblePassword: active);
  }
}
