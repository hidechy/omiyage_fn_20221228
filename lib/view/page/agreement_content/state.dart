import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/model/consent/model.dart';

part 'state.freezed.dart';

@freezed
class AgreementContentState with _$AgreementContentState {
  const factory AgreementContentState({
    // 通信中
    @Default(true) bool fetching,
    // 取得したプラポリ
    PoricyConsentModel? poricyConsent,
    // 取得した個人情報保護方針
    IndividualConsentModel? individualConsent,
    // 取得した利用規約
    TermsConsentModel? termsConsent,
  }) = _AgreementContentState;
}
