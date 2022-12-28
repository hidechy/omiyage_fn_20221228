import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BabyEditState with _$BabyEditState {
  const factory BabyEditState({
    @Default(BabyEditData()) BabyEditData inputData,
    @Default(false) bool saving,
  }) = _BabyEditState;
}

/// 入力中データ
@freezed
class BabyEditData with _$BabyEditData {
  const factory BabyEditData({
    /// 名前（ニックネーム）
    @Default('') String name,

    /// 出産予定日
    DateTime? scheduledBirthday,
  }) = _BabyEditData;
}
