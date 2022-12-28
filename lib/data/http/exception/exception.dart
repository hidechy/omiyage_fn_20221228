import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

@freezed
class HttpStatusException with _$HttpStatusException implements Exception {
  /// メンテナンスモード
  const factory HttpStatusException.maintenanceMode({
    required String msg,
  }) = MaintenanceModeHttpStatusException;

  /// その他
  const factory HttpStatusException.other({
    required String msg,
  }) = OtherHttpStatusException;

  const HttpStatusException._();
}
