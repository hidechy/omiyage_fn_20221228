import 'package:family_notes/data/model/baby/model.dart';
import 'package:family_notes/data/model/child/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/data/repository/baby.dart';
import '/data/repository/child.dart';
import '../../data/http/exception/exception.dart';
import '../../data/model/response/model.dart';
import '../maintenance/notifier.dart';
import 'state.dart';

/// 選択している子どもの取得状態を管理するプロバイダ
final selectedChildStateProvider =
    StateNotifierProvider<SelectedChildNotifier, SelectedChildState>((ref) {
  return SelectedChildNotifier(
    ref: ref,
    babyRepository: ref.watch(babyRepositoryProvider),
    childRepository: ref.watch(childRepositoryProvider),
  );
});

class SelectedChildNotifier extends StateNotifier<SelectedChildState> {
  SelectedChildNotifier({
    required this.ref,
    required this.babyRepository,
    required this.childRepository,
  }) : super(const SelectedChildStateInit());

  final StateNotifierProviderRef ref;
  final BabyRepository babyRepository;
  final ChildRepository childRepository;

  /// 胎児情報取得
  Future<void> fetch({
    required int childId,
    required String childType,
    required Function(String) onFailure,
  }) async {
    if (state is SelectedChildStateLoading) {
      return;
    }
    state = const SelectedChildState.loading();

    switch (childType) {
      case 'baby':
        await babyRepository.fetchBaby(childId: childId).then(
          (IHSResponse<BabyModel> response) {
            final baby = response.data;
            if (response.status == ResponseStatus.failure || baby == null) {
              state = const SelectedChildState.init();
              onFailure(response.msg ?? '予期せぬエラーが発生しました');
              return;
            }

            state = SelectedChildState.loaded(
              childId: childId,
              child: IHSChild.baby(data: baby),
            );
          },
        ).catchError(
          (error, _) {
            _onOccurredError(error, onFailure: onFailure);
          },
        );
        break;
      case 'child':
        await childRepository.fetchChild(childId: childId).then(
          (IHSResponse<ChildModel> response) {
            final baby = response.data;
            if (response.status == ResponseStatus.failure || baby == null) {
              state = const SelectedChildState.init();
              onFailure(response.msg ?? '予期せぬエラーが発生しました');
              return;
            }

            state = SelectedChildState.loaded(
              childId: childId,
              child: IHSChild.child(data: baby),
            );
          },
        ).catchError(
          (error, _) {
            _onOccurredError(error, onFailure: onFailure);
          },
        );
        break;
    }
  }

  void _onOccurredError(
    dynamic error, {
    required Function(String) onFailure,
  }) {
    state = const SelectedChildState.init();

    if (error is MaintenanceModeHttpStatusException) {
      ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
      return;
    }
    onFailure('予期せぬエラーが発生しました');
  }
}
