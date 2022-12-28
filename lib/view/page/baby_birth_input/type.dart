import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../type/gender.dart';

part 'type.freezed.dart';

@freezed
class BabyBirthInputData with _$BabyBirthInputData {
  /// 出生時情報の入力データ
  const factory BabyBirthInputData({
    /// 子ども毎の出生情報
    @Default([]) List<BabyBirthDataByChild> childList,

    /// 妊娠週数
    @Default('') String pregnancyWeeks,

    /// 生まれた場所
    @Default('') String address,

    /// 医師または助産師
    @Default('') String doctor,

    /// パパ、ママの気持ち
    @Default('') String parentFeeling,

    /// 赤ちゃんへのメッセージ
    @Default('') String message,

    /// 自由にコメントを残してください
    @Default('') String freeComment,
  }) = _BabyBirthInputData;
}

@freezed
class BabyBirthDataByChild with _$BabyBirthDataByChild {
  /// 子ども毎の出生情報
  const factory BabyBirthDataByChild({
    required int index,

    /// 名前(ニックネーム)
    @Default('') String name,

    /// 出産日
    DateTime? birthday,

    /// 出産時刻
    TimeOfDay? birthdayTime,

    /// 性別
    Gender? gender,

    /// 身長
    @Default('') String height,

    /// 体重
    @Default('') String weight,

    /// 頭囲
    @Default('') String head,

    /// 胸囲
    @Default('') String chest,
  }) = _BabyBirthDataByChild;
}
