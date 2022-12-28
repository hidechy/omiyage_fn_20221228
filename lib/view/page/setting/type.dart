enum SettingItemType {
  // お子さまを登録・編集
  childSelect,
  // プロフィール情報
  profile,
  // 通知
  notification,
  // 国循データプラットフォーム連携・解除
  kokuzixyun,
  // ログアウト
  logout,
  // 退会
  withdrawal,
}

extension SettingItemTypeEx on SettingItemType {
  String get group {
    switch (this) {
      case SettingItemType.childSelect:
      case SettingItemType.profile:
      case SettingItemType.notification:
        return 'A';
      case SettingItemType.kokuzixyun:
        return 'B';
      case SettingItemType.logout:
      case SettingItemType.withdrawal:
        return 'C';
    }
  }

  String get title {
    switch (this) {
      case SettingItemType.childSelect:
        return 'お子さまを登録・編集';
      case SettingItemType.profile:
        return 'プロフィール情報';
      case SettingItemType.notification:
        return '通知';
      case SettingItemType.kokuzixyun:
        return '国循データプラットフォーム連携・解除';
      case SettingItemType.logout:
        return 'ログアウト';
      case SettingItemType.withdrawal:
        return '退会';
    }
  }
}
