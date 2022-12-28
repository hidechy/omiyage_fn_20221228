import 'package:family_notes/data/local/local_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final Provider<VersionCheck> versionCheckProvider = Provider<VersionCheck>(
  (ProviderRef<VersionCheck> ref) =>
      VersionCheck(localClient: ref.read(localClientProvider)),
);

// true:アップデートする必要がない 　false:アップデートする必要がある
class VersionCheck {
  VersionCheck({required this.localClient});
  final LocalClient localClient;

  Future<bool> checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    // TODO:serverVerは、DBの t_config からフェッチしてくる（ito）
    final serverVer = '1.0.0'.split('.').map(int.parse).toList();
    final deviceVer = version.split('.').map(int.parse).toList();
    // メジャーバージョンの比較
    if (serverVer[0] < deviceVer[0]) {
      return true;
    }
    // マイナーバージョンの比較
    if (serverVer[0] == deviceVer[0] && serverVer[1] <= deviceVer[1]) {
      return true;
    }
    return false;
  }
}
