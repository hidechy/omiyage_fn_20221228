import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/model/pregnant_weight_record_list/model.dart';
import '/view/component/gradation_layout/widget.dart';
import '/view/page/pregnant_weight_record_select/notifier.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';
import '../../component/record_list/widget.dart';
import '../pregnant_weight_record_input/widget.dart';

// 妊婦の体重記録一覧画面
class PregnantWeightRecordSelectPage extends ConsumerWidget {
  const PregnantWeightRecordSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pregnantWeightRecordSelectProvider);

    return GradationLayout(
      title: '体重グラフ',
      showDrawer: false,
      body: SingleChildScrollView(
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
                    _pushToWeightGraphInput(
                      context,
                      state.recordList.list[index],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void _pushToWeightGraphInput(
  BuildContext context,
  PregnantWeightRecord? record,
) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => PregnantWeightRecordInputPage(
        record: record,
      ),
    ),
  );
}
