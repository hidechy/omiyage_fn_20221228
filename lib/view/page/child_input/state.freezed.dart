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
mixin _$ChildInputState {
  ChildInputData get inputData => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildInputStateCopyWith<ChildInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildInputStateCopyWith<$Res> {
  factory $ChildInputStateCopyWith(
          ChildInputState value, $Res Function(ChildInputState) then) =
      _$ChildInputStateCopyWithImpl<$Res, ChildInputState>;
  @useResult
  $Res call({ChildInputData inputData, bool saving});

  $ChildInputDataCopyWith<$Res> get inputData;
}

/// @nodoc
class _$ChildInputStateCopyWithImpl<$Res, $Val extends ChildInputState>
    implements $ChildInputStateCopyWith<$Res> {
  _$ChildInputStateCopyWithImpl(this._value, this._then);

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
              as ChildInputData,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChildInputDataCopyWith<$Res> get inputData {
    return $ChildInputDataCopyWith<$Res>(_value.inputData, (value) {
      return _then(_value.copyWith(inputData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChildInputStateCopyWith<$Res>
    implements $ChildInputStateCopyWith<$Res> {
  factory _$$_ChildInputStateCopyWith(
          _$_ChildInputState value, $Res Function(_$_ChildInputState) then) =
      __$$_ChildInputStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChildInputData inputData, bool saving});

  @override
  $ChildInputDataCopyWith<$Res> get inputData;
}

/// @nodoc
class __$$_ChildInputStateCopyWithImpl<$Res>
    extends _$ChildInputStateCopyWithImpl<$Res, _$_ChildInputState>
    implements _$$_ChildInputStateCopyWith<$Res> {
  __$$_ChildInputStateCopyWithImpl(
      _$_ChildInputState _value, $Res Function(_$_ChildInputState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputData = null,
    Object? saving = null,
  }) {
    return _then(_$_ChildInputState(
      inputData: null == inputData
          ? _value.inputData
          : inputData // ignore: cast_nullable_to_non_nullable
              as ChildInputData,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChildInputState implements _ChildInputState {
  const _$_ChildInputState(
      {this.inputData = const ChildInputData(), this.saving = false});

  @override
  @JsonKey()
  final ChildInputData inputData;
  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'ChildInputState(inputData: $inputData, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildInputState &&
            (identical(other.inputData, inputData) ||
                other.inputData == inputData) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputData, saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildInputStateCopyWith<_$_ChildInputState> get copyWith =>
      __$$_ChildInputStateCopyWithImpl<_$_ChildInputState>(this, _$identity);
}

abstract class _ChildInputState implements ChildInputState {
  const factory _ChildInputState(
      {final ChildInputData inputData, final bool saving}) = _$_ChildInputState;

  @override
  ChildInputData get inputData;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_ChildInputStateCopyWith<_$_ChildInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChildInputData {
  /// 名前（ニックネーム）
  String get name => throw _privateConstructorUsedError;

  /// 性別
  Gender? get gender => throw _privateConstructorUsedError;

  /// 出産予定日
  DateTime? get birthday => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChildInputDataCopyWith<ChildInputData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildInputDataCopyWith<$Res> {
  factory $ChildInputDataCopyWith(
          ChildInputData value, $Res Function(ChildInputData) then) =
      _$ChildInputDataCopyWithImpl<$Res, ChildInputData>;
  @useResult
  $Res call({String name, Gender? gender, DateTime? birthday});
}

/// @nodoc
class _$ChildInputDataCopyWithImpl<$Res, $Val extends ChildInputData>
    implements $ChildInputDataCopyWith<$Res> {
  _$ChildInputDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? gender = freezed,
    Object? birthday = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChildInputDataCopyWith<$Res>
    implements $ChildInputDataCopyWith<$Res> {
  factory _$$_ChildInputDataCopyWith(
          _$_ChildInputData value, $Res Function(_$_ChildInputData) then) =
      __$$_ChildInputDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, Gender? gender, DateTime? birthday});
}

/// @nodoc
class __$$_ChildInputDataCopyWithImpl<$Res>
    extends _$ChildInputDataCopyWithImpl<$Res, _$_ChildInputData>
    implements _$$_ChildInputDataCopyWith<$Res> {
  __$$_ChildInputDataCopyWithImpl(
      _$_ChildInputData _value, $Res Function(_$_ChildInputData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? gender = freezed,
    Object? birthday = freezed,
  }) {
    return _then(_$_ChildInputData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_ChildInputData implements _ChildInputData {
  const _$_ChildInputData({this.name = '', this.gender, this.birthday});

  /// 名前（ニックネーム）
  @override
  @JsonKey()
  final String name;

  /// 性別
  @override
  final Gender? gender;

  /// 出産予定日
  @override
  final DateTime? birthday;

  @override
  String toString() {
    return 'ChildInputData(name: $name, gender: $gender, birthday: $birthday)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildInputData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, gender, birthday);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildInputDataCopyWith<_$_ChildInputData> get copyWith =>
      __$$_ChildInputDataCopyWithImpl<_$_ChildInputData>(this, _$identity);
}

abstract class _ChildInputData implements ChildInputData {
  const factory _ChildInputData(
      {final String name,
      final Gender? gender,
      final DateTime? birthday}) = _$_ChildInputData;

  @override

  /// 名前（ニックネーム）
  String get name;
  @override

  /// 性別
  Gender? get gender;
  @override

  /// 出産予定日
  DateTime? get birthday;
  @override
  @JsonKey(ignore: true)
  _$$_ChildInputDataCopyWith<_$_ChildInputData> get copyWith =>
      throw _privateConstructorUsedError;
}