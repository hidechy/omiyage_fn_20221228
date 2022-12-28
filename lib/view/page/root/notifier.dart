import 'package:family_notes/data/request/consent/request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/model/consent/model.dart';
import '/data/repository/common.dart';
import '../../../data/http/exception/exception.dart';
import '../../../provider/maintenance/notifier.dart';
import 'state.dart';

final rootStateProvider =
    StateNotifierProvider<RootStateNotifier, RootState>((ref) {
  return RootStateNotifier(
    ref: ref,
    commonRepository: ref.watch(commonRepositoryProvider),
  );
});

class RootStateNotifier extends StateNotifier<RootState> {
  RootStateNotifier({
    required this.ref,
    required this.commonRepository,
  }) : super(const RootState());

  final StateNotifierProviderRef ref;
  final CommonRepository commonRepository;

  /// ユーザー同意内容取得
  Future<ConsentListModel?> fetchUserConsenctContents() async {
    if (state.loading) {
      return null;
    }
    state = state.copyWith(loading: true);

    return commonRepository.fetchUserConsentContents().then(
      (model) {
        state = state.copyWith(loading: false);
        return model.data;
      },
    ).catchError(
      (error, _) {
        state = state.copyWith(loading: false);
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        }
      },
    );
  }

  Future<void> onAgreedContent(ConsentModel content) async {
    if (state.loading) {
      return;
    }
    state = state.copyWith(loading: true);

    final request = ConsentContentsConsentRequest(
      type: content.type,
      consentId: content.id,
    );
    await commonRepository.updateConsentContents(request: request).then(
      (model) {
        state = state.copyWith(loading: false);
        return model.data;
      },
    ).catchError(
      (error, _) {
        state = state.copyWith(loading: false);
        if (error is MaintenanceModeHttpStatusException) {
          ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
        }
      },
    );
  }
}
