import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'type.dart';

part 'state.freezed.dart';

@freezed
class BabyBirthInputState with _$BabyBirthInputState {
  const factory BabyBirthInputState.loading() = BabyBirthInputStateLoading;

  const factory BabyBirthInputState.loaded({
    BabyBirthInputData? inputData,
    @Default(false) bool saving,

    /// birthTile も含めたvalidation用
    FormGroup? form,

    /// 妊娠週数
    FormControl<String>? weekController,

    /// パパ、ママの気持ち入力コントローラー
    TextEditingController? parentFeelingController,

    /// 赤ちゃんへのメッセージ入力コントローラー
    TextEditingController? messageController,    

    /// コメント入力コントローラー
    TextEditingController? freeCommentController,      
  }) = BabyBirthInputStateLoaded;
}
