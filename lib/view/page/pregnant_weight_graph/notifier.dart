import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/http/exception/exception.dart';
import '/data/repository/pregnant_weight_record.dart';
import '/provider/child/notifier.dart';
import '/provider/maintenance/notifier.dart';
import '/util/util.dart';
import 'state.dart';

/// 体重グラフ画面の状態を管理するプロバイダー
final pregnantWeightGraphStateProvider = AutoDisposeStateNotifierProvider<
    PregnantWeightGraphNotifier, PregnantWeightGraphState>((ref) {
  return PregnantWeightGraphNotifier(
    ref: ref,
    repository: ref.watch(pregnantWeightRecordRepositoryProvider),
  );
});

class PregnantWeightGraphNotifier
    extends StateNotifier<PregnantWeightGraphState> {
  PregnantWeightGraphNotifier({
    required this.ref,
    required this.repository,
  }) : super(const PregnantWeightGraphState()) {
    fetchRecords();
  }

  final AutoDisposeStateNotifierProviderRef ref;
  final PregnantWeightRecordRepository repository;

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

    await repository.fetchGraphData(childId: childId).then(
      (response) {
        state = state.copyWith(loading: false);
        final data = response.data;

        if (response.isFailure || data == null) {
          _showError(response.msg ?? '予期せぬエラーが発生しました');
          return;
        }

        state = state.copyWith(weightGraphDataList: data.list);
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

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
