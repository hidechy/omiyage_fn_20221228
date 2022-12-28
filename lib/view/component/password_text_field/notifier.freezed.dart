// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PasswordTextFieldeState {
// パスワードの表示
  bool get visiblePassword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PasswordTextFieldeStateCopyWith<PasswordTextFieldeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordTextFieldeStateCopyWith<$Res> {
  factory $PasswordTextFieldeStateCopyWith(PasswordTextFieldeState value,
          $Res Function(PasswordTextFieldeState) then) =
      _$PasswordTextFieldeStateCopyWithImpl<$Res, PasswordTextFieldeState>;
  @useResult
  $Res call({bool visiblePassword});
}

/// @nodoc
class _$PasswordTextFieldeStateCopyWithImpl<$Res,
        $Val extends PasswordTextFieldeState>
    implements $PasswordTextFieldeStateCopyWith<$Res> {
  _$PasswordTextFieldeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visiblePassword = null,
  }) {
    return _then(_value.copyWith(
      visiblePassword: null == visiblePassword
          ? _value.visiblePassword
          : visiblePassword // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PasswordTextFieldeStateCopyWith<$Res>
    implements $PasswordTextFieldeStateCopyWith<$Res> {
  factory _$$_PasswordTextFieldeStateCopyWith(_$_PasswordTextFieldeState value,
          $Res Function(_$_PasswordTextFieldeState) then) =
      __$$_PasswordTextFieldeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool visiblePassword});
}

/// @nodoc
class __$$_PasswordTextFieldeStateCopyWithImpl<$Res>
    extends _$PasswordTextFieldeStateCopyWithImpl<$Res,
        _$_PasswordTextFieldeState>
    implements _$$_PasswordTextFieldeStateCopyWith<$Res> {
  __$$_PasswordTextFieldeStateCopyWithImpl(_$_PasswordTextFieldeState _value,
      $Res Function(_$_PasswordTextFieldeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visiblePassword = null,
  }) {
    return _then(_$_PasswordTextFieldeState(
      visiblePassword: null == visiblePassword
          ? _value.visiblePassword
          : visiblePassword // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PasswordTextFieldeState implements _PasswordTextFieldeState {
  _$_PasswordTextFieldeState({required this.visiblePassword});

// パスワードの表示
  @override
  final bool visiblePassword;

  @override
  String toString() {
    return 'PasswordTextFieldeState(visiblePassword: $visiblePassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordTextFieldeState &&
            (identical(other.visiblePassword, visiblePassword) ||
                other.visiblePassword == visiblePassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visiblePassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PasswordTextFieldeStateCopyWith<_$_PasswordTextFieldeState>
      get copyWith =>
          __$$_PasswordTextFieldeStateCopyWithImpl<_$_PasswordTextFieldeState>(
              this, _$identity);
}

abstract class _PasswordTextFieldeState implements PasswordTextFieldeState {
  factory _PasswordTextFieldeState({required final bool visiblePassword}) =
      _$_PasswordTextFieldeState;

  @override // パスワードの表示
  bool get visiblePassword;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordTextFieldeStateCopyWith<_$_PasswordTextFieldeState>
      get copyWith => throw _privateConstructorUsedError;
}
