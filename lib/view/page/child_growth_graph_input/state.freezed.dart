// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChildGrowthGraphInputState {
  ChildGrowthInputData get inputData => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildGrowthGraphInputStateCopyWith<ChildGrowthGraphInputState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildGrowthGraphInputStateCopyWith<$Res> {
  factory $ChildGrowthGraphInputStateCopyWith(ChildGrowthGraphInputState value,
          $Res Function(ChildGrowthGraphInputState) then) =
      _$ChildGrowthGraphInputStateCopyWithImpl<$Res,
          ChildGrowthGraphInputState>;
  @useResult
  $Res call({ChildGrowthInputData inputData, bool saving});

  $ChildGrowthInputDataCopyWith<$Res> get inputData;
}

/// @nodoc
class _$ChildGrowthGraphInputStateCopyWithImpl<$Res,
        $Val extends ChildGrowthGraphInputState>
    implements $ChildGrowthGraphInputStateCopyWith<$Res> {
  _$ChildGrowthGraphInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputData = null,
    Object? saving = null,
  }) {
    return _then(_value.copyWith(
      inputData: null == inputData
          ? _value.inputData
          : inputData // ignore: cast_nullable_to_non_nullable
              as ChildGrowthInputData,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChildGrowthInputDataCopyWith<$Res> get inputData {
    return $ChildGrowthInputDataCopyWith<$Res>(_value.inputData, (value) {
      return _then(_value.copyWith(inputData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChildGrowthGraphInputStateCopyWith<$Res>
    implements $ChildGrowthGraphInputStateCopyWith<$Res> {
  factory _$$_ChildGrowthGraphInputStateCopyWith(
          _$_ChildGrowthGraphInputState value,
          $Res Function(_$_ChildGrowthGraphInputState) then) =
      __$$_ChildGrowthGraphInputStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChildGrowthInputData inputData, bool saving});

  @override
  $ChildGrowthInputDataCopyWith<$Res> get inputData;
}

/// @nodoc
class __$$_ChildGrowthGraphInputStateCopyWithImpl<$Res>
    extends _$ChildGrowthGraphInputStateCopyWithImpl<$Res,
        _$_ChildGrowthGraphInputState>
    implements _$$_ChildGrowthGraphInputStateCopyWith<$Res> {
  __$$_ChildGrowthGraphInputStateCopyWithImpl(
      _$_ChildGrowthGraphInputState _value,
      $Res Function(_$_ChildGrowthGraphInputState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputData = null,
    Object? saving = null,
  }) {
    return _then(_$_ChildGrowthGraphInputState(
      inputData: null == inputData
          ? _value.inputData
          : inputData // ignore: cast_nullable_to_non_nullable
              as ChildGrowthInputData,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChildGrowthGraphInputState implements _ChildGrowthGraphInputState {
  const _$_ChildGrowthGraphInputState(
      {this.inputData = const ChildGrowthInputData(), this.saving = false});

  @override
  @JsonKey()
  final ChildGrowthInputData inputData;
  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'ChildGrowthGraphInputState(inputData: $inputData, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildGrowthGraphInputState &&
            (identical(other.inputData, inputData) ||
                other.inputData == inputData) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputData, saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildGrowthGraphInputStateCopyWith<_$_ChildGrowthGraphInputState>
      get copyWith => __$$_ChildGrowthGraphInputStateCopyWithImpl<
          _$_ChildGrowthGraphInputState>(this, _$identity);
}

abstract class _ChildGrowthGraphInputState
    implements ChildGrowthGraphInputState {
  const factory _ChildGrowthGraphInputState(
      {final ChildGrowthInputData inputData,
      final bool saving}) = _$_ChildGrowthGraphInputState;

  @override
  ChildGrowthInputData get inputData;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_ChildGrowthGraphInputStateCopyWith<_$_ChildGrowthGraphInputState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChildGrowthInputData {
  /// 測定日
  DateTime? get date => throw _privateConstructorUsedError;

  /// 身長
  String? get height => throw _privateConstructorUsedError;

  /// 体重(g)
  String? get grams => throw _privateConstructorUsedError;

  /// 体重(kg)
  String? get kilograms => throw _privateConstructorUsedError;

  /// kg/g
  WeightType get weightType => throw _privateConstructorUsedError;

  /// 頭囲
  String? get head => throw _privateConstructorUsedError;

  /// 胸囲
  String? get chest => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildGrowthInputDataCopyWith<ChildGrowthInputData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildGrowthInputDataCopyWith<$Res> {
  factory $ChildGrowthInputDataCopyWith(ChildGrowthInputData value,
          $Res Function(ChildGrowthInputData) then) =
      _$ChildGrowthInputDataCopyWithImpl<$Res, ChildGrowthInputData>;
  @useResult
  $Res call(
      {DateTime? date,
      String? height,
      String? grams,
      String? kilograms,
      WeightType weightType,
      String? head,
      String? chest});
}

/// @nodoc
class _$ChildGrowthInputDataCopyWithImpl<$Res,
        $Val extends ChildGrowthInputData>
    implements $ChildGrowthInputDataCopyWith<$Res> {
  _$ChildGrowthInputDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? height = freezed,
    Object? grams = freezed,
    Object? kilograms = freezed,
    Object? weightType = null,
    Object? head = freezed,
    Object? chest = freezed,
  }) {
    return _then(_value.copyWith(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
      grams: freezed == grams
          ? _value.grams
          : grams // ignore: cast_nullable_to_non_nullable
              as String?,
      kilograms: freezed == kilograms
          ? _value.kilograms
          : kilograms // ignore: cast_nullable_to_non_nullable
              as String?,
      weightType: null == weightType
          ? _value.weightType
          : weightType // ignore: cast_nullable_to_non_nullable
              as WeightType,
      head: freezed == head
          ? _value.head
          : head // ignore: cast_nullable_to_non_nullable
              as String?,
      chest: freezed == chest
          ? _value.chest
          : chest // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChildGrowthInputDataCopyWith<$Res>
    implements $ChildGrowthInputDataCopyWith<$Res> {
  factory _$$_ChildGrowthInputDataCopyWith(_$_ChildGrowthInputData value,
          $Res Function(_$_ChildGrowthInputData) then) =
      __$$_ChildGrowthInputDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? date,
      String? height,
      String? grams,
      String? kilograms,
      WeightType weightType,
      String? head,
      String? chest});
}

/// @nodoc
class __$$_ChildGrowthInputDataCopyWithImpl<$Res>
    extends _$ChildGrowthInputDataCopyWithImpl<$Res, _$_ChildGrowthInputData>
    implements _$$_ChildGrowthInputDataCopyWith<$Res> {
  __$$_ChildGrowthInputDataCopyWithImpl(_$_ChildGrowthInputData _value,
      $Res Function(_$_ChildGrowthInputData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? height = freezed,
    Object? grams = freezed,
    Object? kilograms = freezed,
    Object? weightType = null,
    Object? head = freezed,
    Object? chest = freezed,
  }) {
    return _then(_$_ChildGrowthInputData(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String?,
      grams: freezed == grams
          ? _value.grams
          : grams // ignore: cast_nullable_to_non_nullable
              as String?,
      kilograms: freezed == kilograms
          ? _value.kilograms
          : kilograms // ignore: cast_nullable_to_non_nullable
              as String?,
      weightType: null == weightType
          ? _value.weightType
          : weightType // ignore: cast_nullable_to_non_nullable
              as WeightType,
      head: freezed == head
          ? _value.head
          : head // ignore: cast_nullable_to_non_nullable
              as String?,
      chest: freezed == chest
          ? _value.chest
          : chest // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ChildGrowthInputData implements _ChildGrowthInputData {
  const _$_ChildGrowthInputData(
      {this.date,
      this.height,
      this.grams,
      this.kilograms,
      this.weightType = WeightType.kg,
      this.head,
      this.chest});

  /// 測定日
  @override
  final DateTime? date;

  /// 身長
  @override
  final String? height;

  /// 体重(g)
  @override
  final String? grams;

  /// 体重(kg)
  @override
  final String? kilograms;

  /// kg/g
  @override
  @JsonKey()
  final WeightType weightType;

  /// 頭囲
  @override
  final String? head;

  /// 胸囲
  @override
  final String? chest;

  @override
  String toString() {
    return 'ChildGrowthInputData(date: $date, height: $height, grams: $grams, kilograms: $kilograms, weightType: $weightType, head: $head, chest: $chest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildGrowthInputData &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.grams, grams) || other.grams == grams) &&
            (identical(other.kilograms, kilograms) ||
                other.kilograms == kilograms) &&
            (identical(other.weightType, weightType) ||
                other.weightType == weightType) &&
            (identical(other.head, head) || other.head == head) &&
            (identical(other.chest, chest) || other.chest == chest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, date, height, grams, kilograms, weightType, head, chest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildGrowthInputDataCopyWith<_$_ChildGrowthInputData> get copyWith =>
      __$$_ChildGrowthInputDataCopyWithImpl<_$_ChildGrowthInputData>(
          this, _$identity);
}

abstract class _ChildGrowthInputData implements ChildGrowthInputData {
  const factory _ChildGrowthInputData(
      {final DateTime? date,
      final String? height,
      final String? grams,
      final String? kilograms,
      final WeightType weightType,
      final String? head,
      final String? chest}) = _$_ChildGrowthInputData;

  @override

  /// 測定日
  DateTime? get date;
  @override

  /// 身長
  String? get height;
  @override

  /// 体重(g)
  String? get grams;
  @override

  /// 体重(kg)
  String? get kilograms;
  @override

  /// kg/g
  WeightType get weightType;
  @override

  /// 頭囲
  String? get head;
  @override

  /// 胸囲
  String? get chest;
  @override
  @JsonKey(ignore: true)
  _$$_ChildGrowthInputDataCopyWith<_$_ChildGrowthInputData> get copyWith =>
      throw _privateConstructorUsedError;
}
