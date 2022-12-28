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
mixin _$MaintenanceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() off,
    required TResult Function() on,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? off,
    TResult? Function()? on,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? off,
    TResult Function()? on,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MaintenanceStateOff value) off,
    required TResult Function(MaintenanceStateOn value) on,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MaintenanceStateOff value)? off,
    TResult? Function(MaintenanceStateOn value)? on,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MaintenanceStateOff value)? off,
    TResult Function(MaintenanceStateOn value)? on,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaintenanceStateCopyWith<$Res> {
  factory $MaintenanceStateCopyWith(
          MaintenanceState value, $Res Function(MaintenanceState) then) =
      _$MaintenanceStateCopyWithImpl<$Res, MaintenanceState>;
}

/// @nodoc
class _$MaintenanceStateCopyWithImpl<$Res, $Val extends MaintenanceState>
    implements $MaintenanceStateCopyWith<$Res> {
  _$MaintenanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MaintenanceStateOffCopyWith<$Res> {
  factory _$$MaintenanceStateOffCopyWith(_$MaintenanceStateOff value,
          $Res Function(_$MaintenanceStateOff) then) =
      __$$MaintenanceStateOffCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MaintenanceStateOffCopyWithImpl<$Res>
    extends _$MaintenanceStateCopyWithImpl<$Res, _$MaintenanceStateOff>
    implements _$$MaintenanceStateOffCopyWith<$Res> {
  __$$MaintenanceStateOffCopyWithImpl(
      _$MaintenanceStateOff _value, $Res Function(_$MaintenanceStateOff) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MaintenanceStateOff implements MaintenanceStateOff {
  const _$MaintenanceStateOff();

  @override
  String toString() {
    return 'MaintenanceState.off()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MaintenanceStateOff);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() off,
    required TResult Function() on,
  }) {
    return off();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? off,
    TResult? Function()? on,
  }) {
    return off?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? off,
    TResult Function()? on,
    required TResult orElse(),
  }) {
    if (off != null) {
      return off();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MaintenanceStateOff value) off,
    required TResult Function(MaintenanceStateOn value) on,
  }) {
    return off(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MaintenanceStateOff value)? off,
    TResult? Function(MaintenanceStateOn value)? on,
  }) {
    return off?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MaintenanceStateOff value)? off,
    TResult Function(MaintenanceStateOn value)? on,
    required TResult orElse(),
  }) {
    if (off != null) {
      return off(this);
    }
    return orElse();
  }
}

abstract class MaintenanceStateOff implements MaintenanceState {
  const factory MaintenanceStateOff() = _$MaintenanceStateOff;
}

/// @nodoc
abstract class _$$MaintenanceStateOnCopyWith<$Res> {
  factory _$$MaintenanceStateOnCopyWith(_$MaintenanceStateOn value,
          $Res Function(_$MaintenanceStateOn) then) =
      __$$MaintenanceStateOnCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MaintenanceStateOnCopyWithImpl<$Res>
    extends _$MaintenanceStateCopyWithImpl<$Res, _$MaintenanceStateOn>
    implements _$$MaintenanceStateOnCopyWith<$Res> {
  __$$MaintenanceStateOnCopyWithImpl(
      _$MaintenanceStateOn _value, $Res Function(_$MaintenanceStateOn) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MaintenanceStateOn implements MaintenanceStateOn {
  const _$MaintenanceStateOn();

  @override
  String toString() {
    return 'MaintenanceState.on()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MaintenanceStateOn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() off,
    required TResult Function() on,
  }) {
    return on();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? off,
    TResult? Function()? on,
  }) {
    return on?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? off,
    TResult Function()? on,
    required TResult orElse(),
  }) {
    if (on != null) {
      return on();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MaintenanceStateOff value) off,
    required TResult Function(MaintenanceStateOn value) on,
  }) {
    return on(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MaintenanceStateOff value)? off,
    TResult? Function(MaintenanceStateOn value)? on,
  }) {
    return on?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MaintenanceStateOff value)? off,
    TResult Function(MaintenanceStateOn value)? on,
    required TResult orElse(),
  }) {
    if (on != null) {
      return on(this);
    }
    return orElse();
  }
}

abstract class MaintenanceStateOn implements MaintenanceState {
  const factory MaintenanceStateOn() = _$MaintenanceStateOn;
}
