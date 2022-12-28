import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/model/response/model.dart';
import '/data/repository/common.dart';

part 'notifier.freezed.dart';

final maintenanceStateProvider =
    StateNotifierProvider<MaintenanceStateNotifier, MaintenanceState>((ref) {
  return MaintenanceStateNotifier(
    repository: ref.watch(commonRepositoryProvider),
  );
});

@freezed
class MaintenanceState with _$MaintenanceState {
  /// メンテナンスオフ
  const factory MaintenanceState.off() = MaintenanceStateOff;

  /// メンテナンスオン
  const factory MaintenanceState.on() = MaintenanceStateOn;
}

class MaintenanceStateNotifier extends StateNotifier<MaintenanceState> {
  MaintenanceStateNotifier({
    required this.repository,
  }) : super(const MaintenanceStateOff());

  final CommonRepository repository;

  void setMentenanceMode() {
    state = const MaintenanceState.on();
  }

  // コンフィグ取得APIを叩いてメンテナンス状態をリロード
  Future<void> reloadIfNeeded() async {
    if (state is MaintenanceStateOff) {
      return;
    }
    await repository.fetchConfig().then(
      (IHSResponse<Map<String, dynamic>> _) {
        state = const MaintenanceState.off();
      },
    ).catchError(
      (error, _) {
        state = const MaintenanceState.on();
      },
    );
  }
}
