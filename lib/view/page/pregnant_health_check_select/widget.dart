import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/model/checkup_list/model.dart';
import '/extension/string.dart';
import '/view/component/gradation_layout/widget.dart';
import '/view/component/ihs_button/type.dart';
import '/view/component/ihs_button/widget.dart';
import '/view/style/colors.dart';
import '/view/style/text_style.dart';
import '../../component/loading_indicator/widget.dart';
import '../../component/record_list/widget.dart';
import '../pregnant_health_check_input/widget.dart';
import 'notifier.dart';

/// 妊婦健診入力選択画面
class PregnantHealthCheckSelectPage extends ConsumerWidget {
  const PregnantHealthCheckSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pregnantHealthCheckSelectProvider);
    return GradationLayout(
      title: '妊婦健診入力',
      showDrawer: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: state.loading,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    '妊婦健診入力',
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
                      _pushToHealthCheckInput(context, null);
                    },
                  ),
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
                  if (state.checkupList.list.isNotEmpty)
                    RecordListView(
                      records: state.checkupList.list
                          .map(
                            (e) => Record(
                              date: e.checkupDay.toDateTime(
                                DateFormatType.yyyymmddLine,
                              ),
                            ),
                          )
                          .toList(),
                      onTap: (index, record) {
                        _pushToHealthCheckInput(
                          context,
                          state.checkupList.list[index],
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          if (state.loading)
            const LoadingIndicator(),
        ],
      ),
    );
  }

  void _pushToHealthCheckInput(
      BuildContext context, CheckupModel? checkupModel) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            PregnantHealthCheckInputPage(checkupModel: checkupModel),
      ),
    );
  }
}
