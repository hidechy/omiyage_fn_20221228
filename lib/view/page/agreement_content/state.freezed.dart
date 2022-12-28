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
mixin _$AgreementContentState {
// 通信中
  bool get fetching => throw _privateConstructorUsedError; // 取得したプラポリ
  PoricyConsentModel? get poricyConsent =>
      throw _privateConstructorUsedError; // 取得した個人情報保護方針
  IndividualConsentModel? get individualConsent =>
      throw _privateConstructorUsedError; // 取得した利用規約
  TermsConsentModel? get termsConsent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AgreementContentStateCopyWith<AgreementContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgreementContentStateCopyWith<$Res> {
  factory $AgreementContentStateCopyWith(AgreementContentState value,
          $Res Function(AgreementContentState) then) =
      _$AgreementContentStateCopyWithImpl<$Res, AgreementContentState>;
  @useResult
  $Res call(
      {bool fetching,
      PoricyConsentModel? poricyConsent,
      IndividualConsentModel? individualConsent,
      TermsConsentModel? termsConsent});
}

/// @nodoc
class _$AgreementContentStateCopyWithImpl<$Res,
        $Val extends AgreementContentState>
    implements $AgreementContentStateCopyWith<$Res> {
  _$AgreementContentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? poricyConsent = null,
    Object? individualConsent = null,
    Object? termsConsent = null,
  }) {
    return _then(_value.copyWith(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      poricyConsent: null == poricyConsent
          ? _value.poricyConsent
          : poricyConsent // ignore: cast_nullable_to_non_nullable
              as PoricyConsentModel?,
      individualConsent: null == individualConsent
          ? _value.individualConsent
          : individualConsent // ignore: cast_nullable_to_non_nullable
              as IndividualConsentModel?,
      termsConsent: null == termsConsent
          ? _value.termsConsent
          : termsConsent // ignore: cast_nullable_to_non_nullable
              as TermsConsentModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AgreementContentStateCopyWith<$Res>
    implements $AgreementContentStateCopyWith<$Res> {
  factory _$$_AgreementContentStateCopyWith(_$_AgreementContentState value,
          $Res Function(_$_AgreementContentState) then) =
      __$$_AgreementContentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fetching,
      PoricyConsentModel? poricyConsent,
      IndividualConsentModel? individualConsent,
      TermsConsentModel? termsConsent});
}

/// @nodoc
class __$$_AgreementContentStateCopyWithImpl<$Res>
    extends _$AgreementContentStateCopyWithImpl<$Res, _$_AgreementContentState>
    implements _$$_AgreementContentStateCopyWith<$Res> {
  __$$_AgreementContentStateCopyWithImpl(_$_AgreementContentState _value,
      $Res Function(_$_AgreementContentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? poricyConsent = null,
    Object? individualConsent = null,
    Object? termsConsent = null,
  }) {
    return _then(_$_AgreementContentState(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      poricyConsent: null == poricyConsent
          ? _value.poricyConsent
          : poricyConsent // ignore: cast_nullable_to_non_nullable
              as PoricyConsentModel?,
      individualConsent: null == individualConsent
          ? _value.individualConsent
          : individualConsent // ignore: cast_nullable_to_non_nullable
              as IndividualConsentModel?,
      termsConsent: null == termsConsent
          ? _value.termsConsent
          : termsConsent // ignore: cast_nullable_to_non_nullable
              as TermsConsentModel?,
    ));
  }
}

/// @nodoc

class _$_AgreementContentState implements _AgreementContentState {
  const _$_AgreementContentState(
      {this.fetching = true,
      this.poricyConsent,
      this.individualConsent,
      this.termsConsent});

// 通信中
  @override
  @JsonKey()
  final bool fetching;
// 取得したプラポリ
  @override
  final PoricyConsentModel? poricyConsent;
// 取得した個人情報保護方針
  @override
  final IndividualConsentModel? individualConsent;
// 取得した利用規約
  @override
  final TermsConsentModel? termsConsent;

  @override
  String toString() {
    return 'AgreementContentState(fetching: $fetching, poricyConsent: $poricyConsent, individualConsent: $individualConsent, termsConsent: $termsConsent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AgreementContentState &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching) &&
            const DeepCollectionEquality()
                .equals(other.poricyConsent, poricyConsent) &&
            const DeepCollectionEquality()
                .equals(other.individualConsent, individualConsent) &&
            const DeepCollectionEquality()
                .equals(other.termsConsent, termsConsent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fetching,
      const DeepCollectionEquality().hash(poricyConsent),
      const DeepCollectionEquality().hash(individualConsent),
      const DeepCollectionEquality().hash(termsConsent));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AgreementContentStateCopyWith<_$_AgreementContentState> get copyWith =>
      __$$_AgreementContentStateCopyWithImpl<_$_AgreementContentState>(
          this, _$identity);
}

abstract class _AgreementContentState implements AgreementContentState {
  const factory _AgreementContentState(
      {final bool fetching,
      final PoricyConsentModel? poricyConsent,
      final IndividualConsentModel? individualConsent,
      final TermsConsentModel? termsConsent}) = _$_AgreementContentState;

  @override // 通信中
  bool get fetching;
  @override // 取得したプラポリ
  PoricyConsentModel? get poricyConsent;
  @override // 取得した個人情報保護方針
  IndividualConsentModel? get individualConsent;
  @override // 取得した利用規約
  TermsConsentModel? get termsConsent;
  @override
  @JsonKey(ignore: true)
  _$$_AgreementContentStateCopyWith<_$_AgreementContentState> get copyWith =>
      throw _privateConstructorUsedError;
}
