import 'package:family_notes/view/component/password_text_field/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../style/colors.dart';

/// TODO:ValidateTextField に変えていく(ito)

/// ログイン画面などで使用するパスワード入力フィールド
class PasswordTextField extends ConsumerWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordTextFieldStateProvider(key.toString()));
    final notifier =
        ref.watch(passwordTextFieldStateProvider(key.toString()).notifier);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: IHSColors.yellow50,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          suffixIcon: GestureDetector(
            onTap: () =>
                notifier.setVisiblePassword(active: !state.visiblePassword),
            child: state.visiblePassword
                ? const Icon(
                    FontAwesomeIcons.solidEye,
                    color: IHSColors.black800,
                  )
                : const Icon(
                    FontAwesomeIcons.solidEyeSlash,
                    color: IHSColors.black800,
                  ),
          )),
      obscureText: !state.visiblePassword,
    );
  }
}
