import 'package:family_notes/data/model/converter/datetime.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

/// 乳幼児身体発育曲線データ取得APIから返却されるデータモデル
@freezed
class ChildGrowthRecordGraphModel with _$ChildGrowthRecordGraphModel {
  const factory ChildGrowthRecordGraphModel({
    @Default([]) List<GrowthGraphData> growthGraphData,
    @Default([]) List<BandGraphData> bandGraphData,
  }) = _ChildGrowthRecordGraphModel;

  factory ChildGrowthRecordGraphModel.fromJson(Map<String, dynamic> json) =>
      _$ChildGrowthRecordGraphModelFromJson(json);
}

@freezed
class GrowthGraphData with _$GrowthGraphData {
  const factory GrowthGraphData({
    @DateTimeConverter()
    @JsonKey(name: 'measurement_date')
        required DateTime measurementDate,
    required double height,
    required double weight,
    @JsonKey(name: 'head_measurement') required double head,
    @JsonKey(name: 'chest_measurement') required double chest,
  }) = _GrowthGraphData;

  factory GrowthGraphData.fromJson(Map<String, dynamic> json) =>
      _$GrowthGraphDataFromJson(json);
}

@freezed
class BandGraphData with _$BandGraphData {
  const factory BandGraphData({
    @JsonKey(name: 'min_height') required double minHeight,
    @JsonKey(name: 'max_height') required double maxHeight,
    @JsonKey(name: 'min_weight') required double minWeight,
    @JsonKey(name: 'max_weight') required double maxWeight,
    @JsonKey(name: 'min_head_measurement') required double minHead,
    @JsonKey(name: 'max_head_measurement') required double mixHead,
    @JsonKey(name: 'min_chest_measurement') required double minChest,
    @JsonKey(name: 'max_chest_measurement') required double maxChest,
    @DateTimeConverter() @JsonKey(name: 'month_of_age') required DateTime date,
  }) = _BandGraphData;

  factory BandGraphData.fromJson(Map<String, dynamic> json) =>
      _$BandGraphDataFromJson(json);
}
