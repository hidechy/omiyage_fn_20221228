import 'package:family_notes/data/request/notice_list/request.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/model/response/model.dart';
import '../../../data/repository/notice.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import 'state.dart';

final infomationSelectProvider = AutoDisposeStateNotifierProvider<
    InfomationSelectNotifier, InfomationSelectState>((ref) {
  final repository = ref.read(noticeRepositoryProvider);
  return InfomationSelectNotifier(
    repository: repository,
    ref: ref,
  );
});

class InfomationSelectNotifier extends StateNotifier<InfomationSelectState> {
  InfomationSelectNotifier({
    required this.repository,
    required this.ref,
  }) : super(const InfomationSelectStateLoading()) {
    _init();
  }

  final NoticeRepository repository;
  final AutoDisposeStateNotifierProviderRef ref;
  // １回のAPI送信で取得する記事の数
  final int noticesPerFetch = 20;

  Future<void> _init() async {
    // カテゴリー一覧を取得
    await fetchCategoryList();

    // カテゴリーを絞らないお知らせ一覧を取得
    await fetchNotices();
  }

  // カテゴリー一覧を取得する
  Future<void> fetchCategoryList() async {
    await repository.noticeCategories().then(
      (response) {
        final data = response.data;

        if (response.status == ResponseStatus.failure || data == null) {
          _showError(response.msg ?? IHSTexts.error);
          return;
        }

        final list = data.list;
        state = InfomationSelectState.loaded(categories: list);
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        _showError(IHSTexts.error);
      },
    );
  }

  // お知らせ一覧を取得する（最初の20件）
  Future<void> fetchNotices({
    int? categoryId,
    int page = 1,
  }) async {
    final request = NoticeListRequest(
      categoryId: categoryId,
      page: page,
    );

    state = loadedState.copyWith(loading: true);

    await repository.noticeList(request: request).then(
      (response) {
        final data = response.data;

        state = loadedState.copyWith(loading: false);

        if (response.status == ResponseStatus.failure || data == null) {
          _showError(response.msg ?? IHSTexts.error);
          return;
        }

        final noticeList = data.list;

        state = loadedState.copyWith(
          notices:
              page == 1 ? noticeList : [...loadedState.notices, ...noticeList],
          hasOldNotices: noticeList.length == noticesPerFetch,
        );
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        _showError(IHSTexts.error);
      },
    );
  }

  // 表示しているお知らせ一覧の下限を検知したときに追加の記事を取得する
  Future<void> fetchMoreNotices() async {
    state = loadedState.copyWith(page: loadedState.page + 1);
    await fetchNotices(
      categoryId: loadedState.selectedCategoryId,
      page: loadedState.page,
    );
  }

  // カテゴリーのタブをタップした時にお知らせ一覧を取得する
  Future<void> selectCategory(int categoryId) async {
    if (loadedState.selectedCategoryId == categoryId) {
      state = loadedState.copyWith(
        selectedCategoryId: null,
        hasOldNotices: true,
      );
      await fetchNotices();
      return;
    }
    state = loadedState.copyWith(
      selectedCategoryId: categoryId,
      hasOldNotices: true,
    );
    await fetchNotices(
      categoryId: categoryId,
    );
  }

  void setRead({
    required int noticeId,
    required int index,
  }) {
    final readNotice = loadedState.notices
        .firstWhere((notice) => notice.noticeId == noticeId)
        .copyWith(
          readAt: DateTime.now(),
        );
    final updatedNotices = [...loadedState.notices]
      ..replaceRange(index, index + 1, [readNotice]);

    state = loadedState.copyWith(notices: updatedNotices);
  }

  InfomationSelectStateLoaded get loadedState =>
      state as InfomationSelectStateLoaded;
}

void _showError(String msg) {
  IHSUtil.showSnackBar(msg: msg);
}
