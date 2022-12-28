import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/repository/child_growth_record.dart';
import '/provider/child/notifier.dart';
import '../../../data/http/exception/exception.dart';
import '../../../data/model/response/model.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import 'state.dart';

/// 身体発育曲線画面の状態を管理するプロバイダー
final childGraphGraphStateProvider = AutoDisposeStateNotifierProvider<
    ChildGraphTypeNotifier, ChildWeightGraphState>((ref) {
  return ChildGraphTypeNotifier(
    ref: ref,
    repository: ref.watch(childGrowthRecordRepositoryProvider),
  );
});

class ChildGraphTypeNotifier extends StateNotifier<ChildWeightGraphState> {
  ChildGraphTypeNotifier({
    required this.ref,
    required this.repository,
  }) : super(const ChildWeightGraphState()) {
    fetchRecords();
  }

  final AutoDisposeStateNotifierProviderRef ref;
  final ChildGrowthRecordRepository repository;

  Future<void> fetchRecords() async {
    final childId = ref
        .read(selectedChildStateProvider)
        .mapOrNull(loaded: (state) => state.childId);

    if (childId == null) {
      _showError('予期せぬエラーが発生しました');
      return;
    }
    if (state.loading) {
      return;
    }

    state = state.copyWith(loading: true);

    await repository
        .fetchGraphData(
      childId: childId,
      ageCategory: state.selectedChildGrapthPreriod.categoryId,
    )
        .then(
      (response) {
        state = state.copyWith(loading: false);
        final records = response.data;

        if (response.status == ResponseStatus.failure || records == null) {
          _showError(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        state = state.copyWith(
          growthGraphDataList: records.growthGraphData,
          bandGraphDataList: records.bandGraphData,
        );
      },
    ).catchError(
      (error, _) {
        state = state.copyWith(loading: false);

        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        _showError('予期せぬエラーが発生しました');
      },
    );
  }

  void onTapSegmentView(ChildGraphType type) {
    state = state.copyWith(
      selectedGraphType: type,
    );
  }

  void onTapPeriod(ChildGrapthPreriod period) {
    state = state.copyWith(
      growthGraphDataList: [], // リセット
      bandGraphDataList: [], // リセット
      selectedChildGrapthPreriod: period,
    );

    fetchRecords();
  }

  void togglePulldownVisible() {
    state = state.copyWith(
      showPeriodPulldown: !state.showPeriodPulldown,
    );
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
