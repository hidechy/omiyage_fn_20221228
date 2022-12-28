import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/extension/string.dart';
import '/provider/child/notifier.dart';
import '/view/page/pregnant_weight_graph/notifier.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/ihs_button/type.dart';
import '../../component/ihs_button/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../pregnant_weight_record_input/widget.dart';
import '../pregnant_weight_record_select/widget.dart';
import 'chart/widget.dart';

/// 妊婦の体重グラフ画面
class PregnantWeightGraphPage extends ConsumerWidget {
  const PregnantWeightGraphPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pregnantWeightGraphStateProvider);
    final childState = ref.watch(selectedChildStateProvider);
    // 選択中の出産予定日(出産日)を読み込む
    final birthdayStr = childState.map(
      init: (_) => null,
      loading: (_) => null,
      loaded: (state) {
        return state.child.map(
          baby: (baby) => baby.data.birthScheduleDate,
          child: (child) => child.data.birthday,
        );
      },
    );

    return GradationLayout(
      title: '体重グラフ',
      showDrawer: false,
      body: Builder(builder: (context) {
        if (birthdayStr == null) {
          return const LoadingIndicator();
        }

        final birthday = birthdayStr.toDateTime(DateFormatType.yyyymmddhhmmss);
        return Stack(
          children: [
            SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: state.loading,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    WeightChart(
                      birthDay: birthday,
                      records: state.weightGraphDataList,
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 152,
                            child: IHSButton(
                              'データ登録',
                              type: IHSButtonType.primary,
                              onPressed: () {
                                _pushToWeightGraphInput(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: 152,
                            child: IHSButton(
                              '入力一覧',
                              type: IHSButtonType.primary,
                              onPressed: () {
                                _pushToWeightGraphHistory(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            if (state.loading)
              const LoadingIndicator(),
          ],
        );
      }),
    );
  }

  void _pushToWeightGraphInput(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PregnantWeightRecordInputPage(),
      ),
    );
  }

  void _pushToWeightGraphHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PregnantWeightRecordSelectPage(),
      ),
    );
  }
}
