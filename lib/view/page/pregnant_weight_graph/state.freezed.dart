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
mixin _$PregnantWeightGraphState {
// 体重記録リスト
  List<WeightGraphData> get weightGraphDataList =>
      throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PregnantWeightGraphStateCopyWith<PregnantWeightGraphState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PregnantWeightGraphStateCopyWith<$Res> {
  factory $PregnantWeightGraphStateCopyWith(PregnantWeightGraphState value,
          $Res Function(PregnantWeightGraphState) then) =
      _$PregnantWeightGraphStateCopyWithImpl<$Res, PregnantWeightGraphState>;
  @useResult
  $Res call({List<WeightGraphData> weightGraphDataList, bool loading});
}

/// @nodoc
class _$PregnantWeightGraphStateCopyWithImpl<$Res,
        $Val extends PregnantWeightGraphState>
    implements $PregnantWeightGraphStateCopyWith<$Res> {
  _$PregnantWeightGraphStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weightGraphDataList = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      weightGraphDataList: null == weightGraphDataList
          ? _value.weightGraphDataList
          : weightGraphDataList // ignore: cast_nullable_to_non_nullable
              as List<WeightGraphData>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PregnantWeightGraphStateCopyWith<$Res>
    implements $PregnantWeightGraphStateCopyWith<$Res> {
  factory _$$_PregnantWeightGraphStateCopyWith(
          _$_PregnantWeightGraphState value,
          $Res Function(_$_PregnantWeightGraphState) then) =
      __$$_PregnantWeightGraphStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WeightGraphData> weightGraphDataList, bool loading});
}

/// @nodoc
class __$$_PregnantWeightGraphStateCopyWithImpl<$Res>
    extends _$PregnantWeightGraphStateCopyWithImpl<$Res,
        _$_PregnantWeightGraphState>
    implements _$$_PregnantWeightGraphStateCopyWith<$Res> {
  __$$_PregnantWeightGraphStateCopyWithImpl(_$_PregnantWeightGraphState _value,
      $Res Function(_$_PregnantWeightGraphState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weightGraphDataList = null,
    Object? loading = null,
  }) {
    return _then(_$_PregnantWeightGraphState(
      weightGraphDataList: null == weightGraphDataList
          ? _value._weightGraphDataList
          : weightGraphDataList // ignore: cast_nullable_to_non_nullable
              as List<WeightGraphData>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PregnantWeightGraphState implements _PregnantWeightGraphState {
  const _$_PregnantWeightGraphState(
      {final List<WeightGraphData> weightGraphDataList = const [],
      this.loading = false})
      : _weightGraphDataList = weightGraphDataList;

// 体重記録リスト
  final List<WeightGraphData> _weightGraphDataList;
// 体重記録リスト
  @override
  @JsonKey()
  List<WeightGraphData> get weightGraphDataList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weightGraphDataList);
  }

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'PregnantWeightGraphState(weightGraphDataList: $weightGraphDataList, loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PregnantWeightGraphState &&
            const DeepCollectionEquality()
                .equals(other._weightGraphDataList, _weightGraphDataList) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_weightGraphDataList), loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PregnantWeightGraphStateCopyWith<_$_PregnantWeightGraphState>
      get copyWith => __$$_PregnantWeightGraphStateCopyWithImpl<
          _$_PregnantWeightGraphState>(this, _$identity);
}

abstract class _PregnantWeightGraphState implements PregnantWeightGraphState {
  const factory _PregnantWeightGraphState(
      {final List<WeightGraphData> weightGraphDataList,
      final bool loading}) = _$_PregnantWeightGraphState;

  @override // 体重記録リスト
  List<WeightGraphData> get weightGraphDataList;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$_PregnantWeightGraphStateCopyWith<_$_PregnantWeightGraphState>
      get copyWith => throw _privateConstructorUsedError;
}
