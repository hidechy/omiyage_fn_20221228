import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/http/exception/exception.dart';
import '../../../data/model/consent/model.dart';
import '../../../data/repository/common.dart';
import '../../../provider/maintenance/notifier.dart';
import '../../../util/util.dart';
import '../../style/texts.dart';
import 'state.dart';

/// 同意画面の状態を管理するプロバイダー
final agreementContentStateProvider = AutoDisposeStateNotifierProvider<
    AgreementContentNotifier, AgreementContentState>((ref) {
  return AgreementContentNotifier(
    ref: ref,
    commonRepository: ref.watch(commonRepositoryProvider),
  );
});

class AgreementContentNotifier extends StateNotifier<AgreementContentState> {
  AgreementContentNotifier({
    required this.ref,
    required this.commonRepository,
  }) : super(const AgreementContentState()) {
    _fetchConsentContents();
  }

  final AutoDisposeStateNotifierProviderRef<AgreementContentNotifier,
      AgreementContentState> ref;
  final CommonRepository commonRepository;

  // 規約取得
  Future<void> _fetchConsentContents() async {
    await commonRepository.fetchConsentContents().then(
      (response) {
        state = state.copyWith(fetching: false);

        if (response.data == null) {
          return;
        }

        final consentList = response.data!;

        if (consentList.list.isNotEmpty) {
          final poricy = consentList.list.whereType<PoricyConsentModel>().first;
          final individual =
              consentList.list.whereType<IndividualConsentModel>().first;
          final terms = consentList.list.whereType<TermsConsentModel>().first;
          state = state.copyWith(
            poricyConsent: poricy,
            individualConsent: individual,
            termsConsent: terms,
          );
        }
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
