import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/child/notifier.dart';
import '../../../provider/child/state.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/loading_indicator/widget.dart';
import 'body/state.dart';
import 'body/widget.dart';

/// ホーム画面
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChildState = ref.watch(selectedChildStateProvider);

    return selectedChildState.map(
      init: (_) {
        return const LoadingIndicator();
      },
      loading: (_) {
        return const LoadingIndicator();
      },
      loaded: (state) {
        final child = state.child;
        return GradationLayout(
          title: 'ホーム',
          automaticallyImplyLeading: false,
          horizontalPadding: 0,
          body: HomeBodyPage(
            initialLayout:
                child is BabyIHSChild ? HomeLayout.baby : HomeLayout.child,
            child: child,
          ),
        );
      },
    );
  }
}
