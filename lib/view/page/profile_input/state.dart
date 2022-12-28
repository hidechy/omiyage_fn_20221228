import 'package:freezed_annotation/freezed_annotation.dart';

import '../profile_info/state.dart';

part 'state.freezed.dart';

@freezed
class ProfileInputState with _$ProfileInputState {
  const factory ProfileInputState({
    @Default(ProfileInfoData()) ProfileInfoData inputData,
    @Default(false) bool saving,
  }) = _ProfileInputState;
}
