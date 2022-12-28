import 'package:flutter/material.dart';

import '../../style/colors.dart';

/// TODO:ValidateTextField に変えていく(ito)

/// アカウント作成画面などで使用する認証コードフィールド
class CodeTextField extends StatelessWidget {
  const CodeTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: IHSColors.yellow50,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: IHSColors.black800,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: IHSColors.black800,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
    );
  }
}
