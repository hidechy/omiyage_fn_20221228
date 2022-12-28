import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../type/gender.dart';

part 'state.freezed.dart';

@freezed
class ChildInputState with _$ChildInputState {
  const factory ChildInputState({
    @Default(ChildInputData()) ChildInputData inputData,
    @Default(false) bool saving,
  }) = _ChildInputState;
}

/// 入力中データ
@freezed
class ChildInputData with _$ChildInputData {
  const factory ChildInputData({
    /// 名前（ニックネーム）
    @Default('') String name,

    /// 性別
    Gender? gender,

    /// 出産予定日
    DateTime? birthday,
  }) = _ChildInputData;
}
