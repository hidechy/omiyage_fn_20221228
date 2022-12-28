import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extension/date_time.dart';
import '../../../extension/text.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import 'notifier.dart';
import 'state.dart';

/// お知らせ詳細画面
class InformationDetailPage extends ConsumerWidget {
  const InformationDetailPage({
    super.key,
    required this.noticeId,
  });

  final int noticeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        infomationDetailProvider.overrideWithProvider(
          infomationDetailProviderFamily(
            InfomationDetailProviderArg(noticeId: noticeId),
          ),
        ),
      ],
      child: const InformationDetailPageBody(),
    );
  }
}

class InformationDetailPageBody extends ConsumerWidget {
  const InformationDetailPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infomationDetailProvider);

    return GradationLayout(
      title: 'お知らせ',
      showDrawer: false,
      horizontalPadding: 0,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (InfomationDetailStateLoaded state) {
          final _notice = state.notice!;

          return SingleChildScrollView(
            child: Container(
              color: IHSColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _notice.deliveryAt.yyyymmddhhmm,
                    style: IHSTextStyle.xSmall.copyWith(
                      color: IHSColors.black400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _notice.title,
                    style: IHSTextStyle.medium,
                  ),
                  const SizedBox(height: 24),
                  Text(_notice.content).convertUrlToLink(
                    context,
                    textStyle: IHSTextStyle.small,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
