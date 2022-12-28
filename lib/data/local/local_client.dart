// ignore_for_file: constant_identifier_names, unused_element

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<LocalClient> localClientProvider = Provider<LocalClient>(
  (ProviderRef<LocalClient> ref) => LocalClient(),
);

enum LocalKeyType {
  // ユーザーID
  userId,
  // アクセストークン
  accessToken,
  // 選択中の子どもID
  selectedChildId,
  // 選択中の子どもタイプ(babyまたはchild)
  selectedChildType,
}

extension on LocalKeyType {
  String get key {
    switch (this) {
      case LocalKeyType.userId:
        return 'USER_ID';
      case LocalKeyType.accessToken:
        return 'ACCESS_TOKEN';
      case LocalKeyType.selectedChildId:
        return 'SELECTED_CHILD_ID';
      case LocalKeyType.selectedChildType:
        return 'SELECTED_CHILD_TYPE';
    }
  }
}

class LocalClient {
  Future<void> set<T>(LocalKeyType type, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(type.key, value);
    } else if (value is bool) {
      await prefs.setBool(type.key, value);
    } else if (value is int) {
      await prefs.setInt(type.key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(type.key, value);
    } else {
      Exception('Not compatible type');
    }
  }

  Future<T?> get<T>(LocalKeyType type) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(type.key) as T?;
  }

  Future<void> remove(LocalKeyType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(type.key);
  }
}
