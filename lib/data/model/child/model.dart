import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

/// 子ども取得APIから返却されるデータモデル
@freezed
class ChildModel with _$ChildModel {
  const factory ChildModel({
    @JsonKey(name: 'baby_id') required int? babyId,
    @Default('') String nickname,
    int? gender,
    String? birthday,
    @JsonKey(name: 'month_from_birth') int? monthFromBirth,
    double? height,
    double? weight,
    @JsonKey(name: 'head_measurement') double? headMeasurement,
    @JsonKey(name: 'chest_measurement') double? chestMeasurement,
    @JsonKey(name: 'birth_place') String? birthPlace,
    @JsonKey(name: 'birth_doctor') String? birthDoctor,
    @JsonKey(name: 'mother_father_feeling') String? motherFatherFeeling,
    String? message,
    String? comment,
    @JsonKey(name: 'birth_schedule_date') String? birthScheduleDate,
  }) = _ChildModel;

  factory ChildModel.fromJson(Map<String, dynamic> json) =>
      _$ChildModelFromJson(json);
}
