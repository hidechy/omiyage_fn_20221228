import 'package:family_notes/data/model/child_growth_record_list/model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/view/component/gradation_layout/widget.dart';
import '/view/page/child_growth_record_select/notifier.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/record_list/widget.dart';
import '../child_growth_graph_input/widget.dart';

// 子供の身体発育曲線の入力歴画面
class ChildGrowthSelectPage extends ConsumerWidget {
  const ChildGrowthSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(childGrowthRecordSelectProvider);

    return GradationLayout(
      title: '身体発育曲線',
      showDrawer: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: state.loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    '入力一覧',
                    style: IHSTextStyle.medium.copyWith(
                      color: IHSColors.pink500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (state.recordList.list.isNotEmpty)
                    RecordListView(
                      records: state.recordList.list
                          .map((e) => Record(
                                date: e.date,
                              ))
                          .toList(),
                      onTap: (index, record) {
                        _pushToChildGrowthGraphInput(
                          context,
                          state.recordList.list[index],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          if (state.loading) const LoadingIndicator(),
        ],
      ),
    );
  }
}

void _pushToChildGrowthGraphInput(
  BuildContext context,
  ChildGrowthRecord? record,
) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => ChildGrowthGraphInputPage(
        record: record,
      ),
    ),
  );
}
