import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../validate_text_field/type.dart';

class ValidateDatePickTextField extends StatelessWidget {
  const ValidateDatePickTextField(
    this.dateTime, {
    super.key,
    this.title,
    this.hintText,
    this.width,
    this.isRequired = false,
    this.inputAction = TextInputAction.next,
    this.textAlign = TextAlign.left,
    required this.controller,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime? dateTime;

  // フィールドの上に表示するタイトル
  final String? title;

  // フィールドの上に必須を表示する
  final bool isRequired;
  final String? hintText;
  final double? width;
  final TextInputAction inputAction;
  final TextAlign textAlign;

  final FormControl<String> controller;
  final Function(DateTime?) onChanged;
  final int firstDate;
  final int lastDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) FieldTitle(title: title!, isRequired: isRequired),
        SizedBox(
          width: width,
          child: ReactiveTextField<String>(
            key: Key(controller.value.toString()),
            readOnly: true,
            formControl: controller,
            style: IHSTextStyle.small,
            textAlign: textAlign,
            textInputAction: inputAction,
            decoration: InputDecoration(
                filled: true,
                fillColor: IHSColors.white,
                hintText: hintText,
                hintStyle: IHSTextStyle.small.copyWith(
                  color: IHSColors.black200,
                ),
                suffixIcon: isRequired
                    ? Icon(
                        Icons.calendar_month_outlined,
                        color: IHSColors.black800.withOpacity(0.8),
                      )
                    : DeletableIcons(
                        controller: controller,
                        onChanged: onChanged,
                      ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                enabledBorder: _boderStyle(),
                focusedBorder: _boderStyle(),
                errorBorder: _boderStyle(borderColor: IHSColors.red),
                focusedErrorBorder: _boderStyle(borderColor: IHSColors.red),
                errorStyle: IHSTextStyle.xSmall.copyWith(
                  color: IHSColors.red,
                  height: 1,
                )),
            validationMessages: ValidateTextFieldType.date.validationMessage,
            onTap: (_) {
              Future.microtask(() => _showPicker(context));
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final initialDate = dateTime ?? DateTime.now();

    final pickedDate = await showDatePicker(
      locale: const Locale('ja'),
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.add(Duration(days: -365 * firstDate)),
      lastDate: initialDate.add(Duration(days: 365 * lastDate)),
    );

    if (pickedDate == null) {
      return;
    }
    onChanged(pickedDate);
  }

  OutlineInputBorder _boderStyle({
    Color borderColor = IHSColors.black800,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }
}

class DeletableIcons extends StatefulWidget {
  const DeletableIcons({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final FormControl<String> controller;
  final Function(DateTime?) onChanged;

  @override
  State<DeletableIcons> createState() => _DeletableIconsState();
}

class _DeletableIconsState extends State<DeletableIcons> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.value == ''
        ? Icon(
            Icons.calendar_month_outlined,
            color: IHSColors.black800.withOpacity(0.8),
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() {
              widget.controller.value = '';
              widget.onChanged(null);
            }),
            child: Icon(
              Icons.clear_rounded,
              color: IHSColors.black800.withOpacity(0.8),
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
                  color: IHSColors.red,
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
