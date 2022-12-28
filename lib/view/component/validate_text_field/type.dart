import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../style/colors.dart';
import 'custom_validation.dart';
import 'validation.dart';

/// バリデーションをかけるテキストフィールドの種類
enum ValidateTextFieldType {
  // Email
  email,

  // パスワード
  password,

  // パスワード(確認用)
  passwordConfirmation,

  // 新パスワード
  newPassword,

  // 認証コード
  authCode,

  // 少数
  double,

  // 整数のみ
  int,

  // 日付
  date,

  // 郵便番号
  postalCode,

  // 身長
  height,

  // 体重
  weight,

  // 頭囲
  head,

  // 胸囲
  chest,

  /// 子どもの体重(g)
  childGramsWeight,

  /// 子どもの体重(kg)
  childKilogramsWeight,
}

/// それぞれのコントローラー
FormControl<String> getController({
  required ValidateTextFieldType type,
  required String value,
  bool isRequired = true,
  Map<String, dynamic>? Function(AbstractControl<dynamic>)? validator,
}) {
  switch (type) {
    case ValidateTextFieldType.email:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.email,
        ],
      );
    case ValidateTextFieldType.password:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(passwordReg),
        ],
      );

    case ValidateTextFieldType.passwordConfirmation:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(passwordReg),
        ],
      );

    case ValidateTextFieldType.newPassword:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(passwordReg),
        ],
      );

    case ValidateTextFieldType.authCode:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(authCodeReg),
        ],
      );

    case ValidateTextFieldType.double:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(doubleReg),
          if (validator != null) validator,
        ],
      );

    case ValidateTextFieldType.int:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(intReg),
          if (validator != null) validator,
        ],
      );
    case ValidateTextFieldType.date:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
        ],
      );

    case ValidateTextFieldType.postalCode:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(postalCodeReg),
        ],
      );
    case ValidateTextFieldType.height:
      return FormControl<String>(
        value: value,
        validators: [
          Validators.pattern(doubleReg),
          if (validator != null) validator,
        ],
      );

    case ValidateTextFieldType.weight:
      return FormControl<String>(
        value: value,
        validators: [
          if (isRequired) Validators.required,
          Validators.pattern(doubleReg),
        ],
      );

    case ValidateTextFieldType.head:
      return FormControl<String>(
        value: value,
        validators: [
          Validators.pattern(doubleReg),
          if (validator != null) validator,
        ],
      );

    case ValidateTextFieldType.chest:
      return FormControl<String>(
        value: value,
        validators: [
          Validators.pattern(doubleReg),
          if (validator != null) validator,
        ],
      );

    case ValidateTextFieldType.childGramsWeight:
      return FormControl<String>(
        value: value,
        validators: [
          Validators.pattern(intStartNonZeroReg),
          if (validator != null) validator,
        ],
      );

    case ValidateTextFieldType.childKilogramsWeight:
      return FormControl<String>(
        value: value,
        validators: [
          if (validator != null) validator,
        ],
      );
  }
}

extension ValidateTextFieldTypeEx on ValidateTextFieldType {
  /// それぞれのテキストフィールドで使用するエラーメッセージのMap
  Map<String, ValidationMessageFunction> get validationMessage {
    switch (this) {
      case ValidateTextFieldType.email:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.email: (error) => ValidationType.email.errorText,
        };
      case ValidateTextFieldType.password:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) =>
              ValidationType.password.errorText,
        };
      case ValidateTextFieldType.passwordConfirmation:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) =>
              ValidationType.password.errorText,
          ValidationMessage.mustMatch: (error) =>
              ValidationType.mustMatch.errorText,
        };
      case ValidateTextFieldType.newPassword:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) =>
              ValidationType.password.errorText,
          CustomValidationMessage.mustNotMutch: (error) =>
              ValidationType.newPassword.errorText
        };
      case ValidateTextFieldType.authCode:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) =>
              ValidationType.authCode.errorText,
        };
      case ValidateTextFieldType.double:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) => ValidationType.double.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.numValid.errorText,
        };
      case ValidateTextFieldType.int:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) => ValidationType.int.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.numValid.errorText,
        };
      case ValidateTextFieldType.date:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
        };
      case ValidateTextFieldType.postalCode:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.required.errorText,
          ValidationMessage.pattern: (error) =>
              ValidationType.postalCode.errorText,
        };
      case ValidateTextFieldType.height:
        return {
          ValidationMessage.pattern: (error) => ValidationType.double.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.height.errorText,
        };
      case ValidateTextFieldType.weight:
        return {
          ValidationMessage.required: (error) =>
              ValidationType.requiredShort.errorText,
          ValidationMessage.pattern: (error) => ValidationType.double.errorText,
        };
      case ValidateTextFieldType.head:
        return {
          ValidationMessage.pattern: (error) => ValidationType.double.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.head.errorText,
        };
      case ValidateTextFieldType.chest:
        return {
          ValidationMessage.pattern: (error) => ValidationType.double.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.chest.errorText,
        };
      case ValidateTextFieldType.childGramsWeight:
        return {
          ValidationMessage.pattern: (error) =>
              ValidationType.intStartNonZeroReg.errorText,
          ValidationType.numValid.name: (error) =>
              ValidationType.childGramsWeight.errorText,
        };
      case ValidateTextFieldType.childKilogramsWeight:
        return {
          ValidationType.numValid.name: (error) =>
              ValidationType.childKilogramsWeight.errorText,
        };
    }
  }

  Color get fillColor {
    switch (this) {
      case ValidateTextFieldType.email:
      case ValidateTextFieldType.password:
      case ValidateTextFieldType.passwordConfirmation:
      case ValidateTextFieldType.newPassword:
      case ValidateTextFieldType.authCode:
        return IHSColors.yellow50;
      case ValidateTextFieldType.double:
      case ValidateTextFieldType.int:
      case ValidateTextFieldType.date:
      case ValidateTextFieldType.height:
      case ValidateTextFieldType.weight:
      case ValidateTextFieldType.head:
      case ValidateTextFieldType.chest:
      case ValidateTextFieldType.childGramsWeight:
      case ValidateTextFieldType.childKilogramsWeight:
      case ValidateTextFieldType.postalCode:
        return IHSColors.white;
    }
  }

  double get borderRadius {
    switch (this) {
      case ValidateTextFieldType.email:
      case ValidateTextFieldType.password:
      case ValidateTextFieldType.passwordConfirmation:
      case ValidateTextFieldType.newPassword:
      case ValidateTextFieldType.authCode:
        return 16;
      case ValidateTextFieldType.double:
      case ValidateTextFieldType.int:
      case ValidateTextFieldType.date:
      case ValidateTextFieldType.height:
      case ValidateTextFieldType.weight:
      case ValidateTextFieldType.head:
      case ValidateTextFieldType.chest:
      case ValidateTextFieldType.childGramsWeight:
      case ValidateTextFieldType.childKilogramsWeight:
      case ValidateTextFieldType.postalCode:
        return 8;
    }
  }
}
