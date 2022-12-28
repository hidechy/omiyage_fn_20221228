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
mixin _$SettingNotificationState {
// 有効無効
  bool get permission => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingNotificationStateCopyWith<SettingNotificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingNotificationStateCopyWith<$Res> {
  factory $SettingNotificationStateCopyWith(SettingNotificationState value,
          $Res Function(SettingNotificationState) then) =
      _$SettingNotificationStateCopyWithImpl<$Res, SettingNotificationState>;
  @useResult
  $Res call({bool permission});
}

/// @nodoc
class _$SettingNotificationStateCopyWithImpl<$Res,
        $Val extends SettingNotificationState>
    implements $SettingNotificationStateCopyWith<$Res> {
  _$SettingNotificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permission = null,
  }) {
    return _then(_value.copyWith(
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingNotificationStateCopyWith<$Res>
    implements $SettingNotificationStateCopyWith<$Res> {
  factory _$$_SettingNotificationStateCopyWith(
          _$_SettingNotificationState value,
          $Res Function(_$_SettingNotificationState) then) =
      __$$_SettingNotificationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool permission});
}

/// @nodoc
class __$$_SettingNotificationStateCopyWithImpl<$Res>
    extends _$SettingNotificationStateCopyWithImpl<$Res,
        _$_SettingNotificationState>
    implements _$$_SettingNotificationStateCopyWith<$Res> {
  __$$_SettingNotificationStateCopyWithImpl(_$_SettingNotificationState _value,
      $Res Function(_$_SettingNotificationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permission = null,
  }) {
    return _then(_$_SettingNotificationState(
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SettingNotificationState implements _SettingNotificationState {
  const _$_SettingNotificationState({this.permission = true});

// 有効無効
  @override
  @JsonKey()
  final bool permission;

  @override
  String toString() {
    return 'SettingNotificationState(permission: $permission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingNotificationState &&
            (identical(other.permission, permission) ||
                other.permission == permission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, permission);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingNotificationStateCopyWith<_$_SettingNotificationState>
      get copyWith => __$$_SettingNotificationStateCopyWithImpl<
          _$_SettingNotificationState>(this, _$identity);
}

abstract class _SettingNotificationState implements SettingNotificationState {
  const factory _SettingNotificationState({final bool permission}) =
      _$_SettingNotificationState;

  @override // 有効無効
  bool get permission;
  @override
  @JsonKey(ignore: true)
  _$$_SettingNotificationStateCopyWith<_$_SettingNotificationState>
      get copyWith => throw _privateConstructorUsedError;
}
