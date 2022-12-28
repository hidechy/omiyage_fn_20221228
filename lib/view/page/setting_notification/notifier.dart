// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:family_notes/data/model/response/model.dart';
import 'package:family_notes/util/util.dart';
import 'package:family_notes/view/style/texts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/repository/notification_settings.dart';
import '../../../data/http/exception/exception.dart';
import '../../../provider/maintenance/notifier.dart';
import 'state.dart';

/// 設定画面の状態を管理するプロバイダー
final settingNotificationProvider = AutoDisposeStateNotifierProvider<
    NotificationPermissionNotifier, SettingNotificationState>((ref) {
  return NotificationPermissionNotifier(
    ref: ref,
    notificationPermissionRepository:
        ref.watch(notificationPermissionRepositoryProvider),
  );
});

class NotificationPermissionNotifier
    extends StateNotifier<SettingNotificationState> {
  NotificationPermissionNotifier({
    required this.ref,
    required this.notificationPermissionRepository,
  }) : super(const SettingNotificationState()) {
    getNotificationPermission();
  }

  final AutoDisposeStateNotifierProviderRef<NotificationPermissionNotifier,
      SettingNotificationState> ref;
  final NotificationPermissionRepository notificationPermissionRepository;

  //
  Future<void> setNotificationPermission({required bool enable}) async {
    {
      final setNum = enable ? 1 : 0;
      await notificationPermissionRepository
          .changeNotificationPermission(enable: setNum)
          .then((response) {
        if (response.status != ResponseStatus.success) {
          _showError(response.msg ?? IHSTexts.error);
          return;
        }
        state = state.copyWith(
          permission: enable,
        );
      }).catchError(
        (error, _) {
          if (error is MaintenanceModeHttpStatusException) {
            ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
            return;
          }
          _showError(IHSTexts.error);
        },
      );
    }
  }

  // 取得
  Future<void> getNotificationPermission() async {
    {
      await notificationPermissionRepository.getNotificationPermission().then(
        (response) {
          if ((response.status != ResponseStatus.success) ||
              (response.data == null)) {
            _showError(response.msg ?? IHSTexts.error);
            return;
          }
          state = state.copyWith(
            permission: int.parse(response.data!) == 0 ? false : true,
          );
        },
      ).catchError(
        (error, _) {
          if (error is MaintenanceModeHttpStatusException) {
            ref.read(maintenanceStateProvider.notifier).setMentenanceMode();
            return;
          }
          _showError(IHSTexts.error);
        },
      );
    }
  }

  void _showError(String msg) {
    IHSUtil.showSnackBar(msg: msg);
  }
}
