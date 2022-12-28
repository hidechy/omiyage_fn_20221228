import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/notice_list/model.dart';
import '../../../extension/date_time.dart';
import '../../component/gradation_layout/widget.dart';
import '../../component/loading_indicator/widget.dart';
import '../../style/colors.dart';
import '../../style/text_style.dart';
import '../bottom_bar/notifier.dart';
import '../information_detail/widget.dart';
import 'notifier.dart';
import 'slider_tags/widget.dart';
import 'state.dart';

/// お知らせ一覧の画面
class InformationSelectPage extends ConsumerWidget {
  const InformationSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infomationSelectProvider);

    return GradationLayout(
      title: 'お知らせ',
      automaticallyImplyLeading: false,
      horizontalPadding: 0,
      body: state.map(
        loading: (_) => const LoadingIndicator(),
        loaded: (InfomationSelectStateLoaded state) {
          final notifier = ref.read(infomationSelectProvider.notifier);

          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 28),
                  const SliderTags(),
                  const SizedBox(height: 36),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        Future.microtask(() async {
                          if (scrollNotification is OverscrollNotification) {
                            // リストの下限をさらに下にスクロールした時
                            if (scrollNotification.overscroll > 10 &&
                                state.hasOldNotices) {
                              await notifier.fetchMoreNotices();
                            }
                            // リストの上限を下に引き下げた時（pull to refresh）
                            if (scrollNotification.overscroll < -10) {
                              await notifier.fetchNotices(
                                categoryId: state.selectedCategoryId,
                              );
                            }
                          }
                        });

                        return true;
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.notices.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final _notice = state.notices[index];
                          return NoticeTile(
                            key: Key(_notice.noticeId.toString()),
                            notice: state.notices[index],
                            onTap: () async {
                              await _toDetailPage(
                                context,
                                id: state.notices[index].noticeId,
                              );
                              // 読まれた記事を既読にする
                              notifier.setRead(
                                noticeId: state.notices[index].noticeId,
                                index: index,
                              );

                              // ボトムバーのバッジ色変更のためにお知らせ確認を再取得する
                              // 未読がある場合はピンク、ない場合は灰色に変わる
                              await ref
                                  .watch(readConfirmationStateProvider.notifier)
                                  .fetchNoticeReadConfirmation();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (state.loading) const LoadingIndicator()
            ],
          );
        },
      ),
    );
  }
}

class NoticeTile extends StatelessWidget {
  const NoticeTile({
    super.key,
    required this.notice,
    required this.onTap,
  });

  final NoticeListItemModel notice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isRead = notice.readAt != null;

    return Container(
      color: IHSColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isRead) ...[
                        const NewMark(),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        notice.deliveryAt.yyyymmdd,
                        style: IHSTextStyle.xSmall.copyWith(
                          color: IHSColors.black400,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notice.title,
                    style: IHSTextStyle.small,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}

Future<void> _toDetailPage(
  BuildContext context, {
  required int id,
}) async {
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => InformationDetailPage(noticeId: id),
    ),
  );
}

class NewMark extends StatelessWidget {
  const NewMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: IHSColors.pink400,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'NEW',
        style: IHSTextStyle.xxSmall.copyWith(
          color: IHSColors.white,
        ),
      ),
    );
  }
}
