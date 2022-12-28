import 'package:family_notes/data/repository/common.dart';
import 'package:family_notes/data/request/consent/request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/http/exception/exception.dart';
import '../../../../data/model/consent/model.dart';
import '../../../../provider/maintenance/notifier.dart';
import '../../../../util/util.dart';
import '../../../style/texts.dart';
import 'state.dart';

/// ホーム画面のBodyの状態を管理するプロバイダー
final homeBodyPageStateProvider = AutoDisposeStateNotifierProvider<
    HomeBodyPageStateNotifier, HomeBodyPageState>((ref) {
  return HomeBodyPageStateNotifier(
    ref: ref,
    commonRepository: ref.watch(commonRepositoryProvider),
  );
});

class HomeBodyPageStateNotifier extends StateNotifier<HomeBodyPageState> {
  HomeBodyPageStateNotifier({
    required this.ref,
    required this.commonRepository,
  }) : super(const HomeBodyPageState.init());

  final StateNotifierProviderRef ref;
  final CommonRepository commonRepository;

  Future<void> setup({
    required HomeLayout initialLayout,
    required Function(List<ConsentModel> consentList) onSuccess,
  }) async {
    state = HomeBodyPageState.loaded(currentLayout: initialLayout);
    await commonRepository.fetchUserConsentContents().then((response) {
      final data = response.data;
      if (response.isFailure || data == null) {
        _showError(response.msg ?? IHSTexts.error);
        return;
      }

      onSuccess(data.list);
    }).catchError((error) {
      if (error is MaintenanceModeHttpStatusException) {
        ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
      }

      _showError(IHSTexts.error);
    });
  }

  Future<void> onTap() async {
    switch ((state as HomeBodyPageStateLoaded).currentLayout) {
      case HomeLayout.baby:
        state = const HomeBodyPageState.loaded(currentLayout: HomeLayout.child);

        break;
      case HomeLayout.child:
        state = const HomeBodyPageState.loaded(currentLayout: HomeLayout.baby);
        break;
    }
  }

  Future<void> updateConsent(
      {required int type, required int consentId}) async {
    final request = ConsentContentsConsentRequest(
      type: type,
      consentId: consentId,
    );
    await commonRepository
        .updateConsentContents(request: request)
        .catchError((error) {
      if (error is MaintenanceModeHttpStatusException) {
        ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
      }

      _showError(IHSTexts.error);
    });
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
