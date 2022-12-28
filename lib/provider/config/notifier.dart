import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/http/exception/exception.dart';
import '/data/model/response/model.dart';
import '/data/repository/common.dart';
import '../maintenance/notifier.dart';

part 'notifier.freezed.dart';

final appConfigProvider =
    StateNotifierProvider<AppConfigStateNotifier, AppConfigState>((ref) {
  return AppConfigStateNotifier(
    ref: ref,
    repository: ref.watch(commonRepositoryProvider),
  );
});

@freezed
class AppConfigState with _$AppConfigState {
  /// 初期状態(アプリ起動直後)
  const factory AppConfigState.init() = AppConfigStateInit;

  const factory AppConfigState.loaded({
    required Map<String, dynamic> config,
  }) = AppConfigStateLoaded;
}

class AppConfigStateNotifier extends StateNotifier<AppConfigState> {
  AppConfigStateNotifier({
    required this.ref,
    required this.repository,
  }) : super(const AppConfigStateInit());

  final StateNotifierProviderRef ref;
  final CommonRepository repository;

  // コンフィグ取得
  Future<void> fetch({
    required Function(String) onFailure,
  }) async {
    await repository.fetchConfig().then(
      (IHSResponse<Map<String, dynamic>> response) {
        final config = response.data;
        if (response.status == ResponseStatus.failure || config == null) {
          return;
        }

        state = AppConfigState.loaded(
          config: config,
        );
      },
    ).catchError(
      (error, _) {
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
          return;
        }
        onFailure('予期せぬエラーが発生しました');
      },
    );
  }
}
