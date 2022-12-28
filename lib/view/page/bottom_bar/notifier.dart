import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/repository/notice.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import '../../style/texts.dart';

import 'state.dart';
import 'type.dart';

@immutable
class BottomBarState {
  const BottomBarState({required this.tabIndex});

  final int tabIndex;
}

final bottomBarStateProvider =
    StateNotifierProvider<BottomBarStateNotifier, BottomBarState>((ref) {
  return BottomBarStateNotifier();
});

class BottomBarStateNotifier extends StateNotifier<BottomBarState> {
  BottomBarStateNotifier() : super(const BottomBarState(tabIndex: 0));

  void setTabIndex(int index) {
    state = BottomBarState(tabIndex: index);
  }
}

/// お知らせ新着を管理するプロバイダー
final readConfirmationStateProvider = AutoDisposeStateNotifierProvider<
    NoticeReadConfirmationNotifier, NoticeReadConfirmationState>((ref) {
  return NoticeReadConfirmationNotifier(
    ref: ref,
    repository: ref.read(noticeRepositoryProvider),
  )..fetchNoticeReadConfirmation();
});

class NoticeReadConfirmationNotifier
    extends StateNotifier<NoticeReadConfirmationState> {
  NoticeReadConfirmationNotifier({required this.ref, required this.repository})
      : super(
          NoticeReadConfirmationState(
            isArrival: ReadConfirmation.alreadyRead.num,
          ),
        );

  AutoDisposeStateNotifierProviderRef<NoticeReadConfirmationNotifier,
      NoticeReadConfirmationState> ref;
  final NoticeRepository repository;

  // お知らせ新着取得
  Future<void> fetchNoticeReadConfirmation() async {
    await repository.noticeReadConfirmation().then(
      (response) {
        state = state.copyWith(fetching: false);

        if (response.data == null) {
          return;
        }

        final noticeReadConfirmation = response.data!;

        state = state.copyWith(isArrival: noticeReadConfirmation.isArrival);
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        IHSUtil.showSnackBar(msg: IHSTexts.error);
      },
    );
  }
}
