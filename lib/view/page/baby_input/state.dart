import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BabyInputState with _$BabyInputState {
  const factory BabyInputState({
    @Default(BabyInputData()) BabyInputData inputData,
    @Default(false) bool saving,
  }) = _BabyInputState;
}

/// 入力中データ
@freezed
class BabyInputData with _$BabyInputData {
  const factory BabyInputData({
    /// 名前（ニックネーム）
    @Default('') String name,

    /// 出産予定日
    DateTime? scheduledBirthday,
  }) = _BabyInputData;
}
