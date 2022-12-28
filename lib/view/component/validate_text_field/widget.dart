import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'type.dart';

/// バリデーションが必要な値のテキストフィールドコンポーネント
class ValidateTextField extends HookWidget {
  const ValidateTextField({
    super.key,
    this.title,
    this.hintText,
    this.width,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.textAlign = TextAlign.left,
    required this.type,
    required this.controller,
    required this.onChanged,
    this.readOnly = false,
    this.borderColor = IHSColors.black800,
  });

  // フィールドの上に表示するタイトル
  final String? title;

  // フィールドの上に必須を表示する
  final bool isRequired;
  final String? hintText;
  final double? width;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final TextAlign textAlign;

  final ValidateTextFieldType type;
  final FormControl<String> controller;
  final Function(String) onChanged;
  final bool readOnly;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final isVisible = useState<bool>(false);
    final isPasswordInputField = type == ValidateTextFieldType.password ||
        type == ValidateTextFieldType.newPassword ||
        type == ValidateTextFieldType.passwordConfirmation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) FieldTitle(title: title!, isRequired: isRequired),
        SizedBox(
          width: width,
          child: ReactiveTextField<String>(
            formControl: controller,
            style: IHSTextStyle.small,
            textAlign: textAlign,
            keyboardType: keyboardType,
            textInputAction: inputAction,
            readOnly: readOnly,
            obscureText: isPasswordInputField && !isVisible.value,
            showErrors: (control) {
              if (type == ValidateTextFieldType.passwordConfirmation) {
                return control.touched && control.invalid && control.dirty;
              }
              return control.touched && control.invalid;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: type.fillColor,
                hintText: hintText,
                hintStyle:
                    IHSTextStyle.small.copyWith(color: IHSColors.black200),
                suffixIcon: isPasswordInputField
                    ? _visibleIcon(isVisible: isVisible)
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                enabledBorder: _boderStyle,
                focusedBorder: _boderStyle,
                errorBorder: _errorBoderStyle,
                focusedErrorBorder: _errorBoderStyle,
                errorStyle: IHSTextStyle.xSmall.copyWith(
                  color: IHSColors.red,
                  height: 1.2,
                )),
            validationMessages: type.validationMessage,
            onChanged: (control) => onChanged(control.value ?? ''),
          ),
        ),
      ],
    );
  }

  GestureDetector _visibleIcon({required ValueNotifier<bool> isVisible}) {
    return GestureDetector(
      onTap: () => isVisible.value = !isVisible.value,
      child: isVisible.value
          ? const Icon(
              FontAwesomeIcons.solidEye,
              color: IHSColors.black800,
              size: 20,
            )
          : const Icon(
              FontAwesomeIcons.solidEyeSlash,
              color: IHSColors.black800,
              size: 20,
            ),
    );
  }

  OutlineInputBorder get _boderStyle {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(type.borderRadius),
    );
  }

  OutlineInputBorder get _errorBoderStyle {
    return _boderStyle.copyWith(
      borderSide: const BorderSide(
        color: IHSColors.red,
        width: 1.5,
      ),
    );
  }
}

class FieldTitle extends StatelessWidget {
  const FieldTitle({
    super.key,
    required this.title,
    required this.isRequired,
  });

  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: IHSTextStyle.small.copyWith(
                height: 1,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 8),
              Text(
                '必須',
                style: IHSTextStyle.xSmall.copyWith(
                  color: const Color(0xffFE0000),
                  height: 1,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
