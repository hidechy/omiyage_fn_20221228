enum AgreementContentType {
  // 個人情報保護方針
  individual,
  // プライバシーポリシー
  privacyPolicy,
  // 利用規約
  terms,
}

extension SettingItemTypeEx on AgreementContentType {
  String get title {
    switch (this) {
      case AgreementContentType.individual:
        return '個人情報保護方針';
      case AgreementContentType.privacyPolicy:
        return 'プライバシーポリシー';
      case AgreementContentType.terms:
        return '利用規約';
    }
  }

  int get value {
    switch (this) {
      case AgreementContentType.privacyPolicy:
        return 1;
      case AgreementContentType.individual:
        return 2;
      case AgreementContentType.terms:
        return 3;
    }
  }
}
