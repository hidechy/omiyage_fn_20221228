import 'package:family_notes/view/component/gradation_layout/widget.dart';
import 'package:family_notes/view/component/ihs_button/type.dart';
import 'package:family_notes/view/component/ihs_button/widget.dart';
import 'package:family_notes/view/component/loading_indicator/widget.dart';
import 'package:family_notes/view/page/pregnant_dental_check_select/notifier.dart';
import 'package:family_notes/view/style/colors.dart';
import 'package:family_notes/view/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../component/record_list/widget.dart';
import '../pregnant_dental_check_input/widget.dart';
import 'type.dart';

/// 妊婦歯科健診入力選択画面
class PregnantDentalCheckSelectPage extends ConsumerWidget {
  const PregnantDentalCheckSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pregnantDentalCheckSelectProvider);

    return GradationLayout(
      title: '妊婦・産後歯科健診入力',
      showDrawer: false,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (loadedState) {
          final records = loadedState.list;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  '歯科健診入力',
                  style: IHSTextStyle.medium.copyWith(
                    color: IHSColors.pink500,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  '新規で健診結果を記録する場合は、\n下のボタンをタップしてください。',
                  style: IHSTextStyle.small,
                ),
                const SizedBox(height: 32),
                IHSButton(
                  '健診結果入力',
                  type: IHSButtonType.primary,
                  onPressed: () {
                    _pushToDentalCheckInput(
                      context,
                      const PregnantDentalCheckInputType.new(),
                    );
                  },
                ),
                if (records.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        '記録一覧',
                        style: IHSTextStyle.medium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: IHSColors.white,
                      border: Border.all(
                        color: IHSColors.black200,
                      ),
                    ),
                    child: RecordListView(
                      records: records
                          .map((e) => Record(date: e.checkupDay))
                          .toList(),
                      onTap: (index, record) {
                        _pushToDentalCheckInput(
                          context,
                          PregnantDentalCheckInputType.edit(
                            motherDentalCheckupRecordId:
                                records[index].motherDentalCheckupRecordId,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _pushToDentalCheckInput(
    BuildContext context,
    PregnantDentalCheckInputType type,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PregnantDentalCheckInputPage(inputType: type),
      ),
    );
  }
}
