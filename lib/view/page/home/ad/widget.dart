import 'package:flutter/material.dart';

/// ホーム画面の広告ウィジェット
class HomeAdBanner extends StatelessWidget {
  const HomeAdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: 24),
        Expanded(
          child: SizedBox(
            height: 65,
            child: Placeholder(),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: SizedBox(
            height: 65,
            child: Placeholder(),
          ),
        ),
        SizedBox(width: 24),
      ],
    );
  }
}
