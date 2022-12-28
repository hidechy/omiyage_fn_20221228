// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChildModel _$ChildModelFromJson(Map<String, dynamic> json) {
  return _ChildModel.fromJson(json);
}

/// @nodoc
mixin _$ChildModel {
  @JsonKey(name: 'baby_id')
  int? get babyId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  int? get gender => throw _privateConstructorUsedError;
  String? get birthday => throw _privateConstructorUsedError;
  @JsonKey(name: 'month_from_birth')
  int? get monthFromBirth => throw _privateConstructorUsedError;
  double? get height => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  @JsonKey(name: 'head_measurement')
  double? get headMeasurement => throw _privateConstructorUsedError;
  @JsonKey(name: 'chest_measurement')
  double? get chestMeasurement => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_place')
  String? get birthPlace => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_doctor')
  String? get birthDoctor => throw _privateConstructorUsedError;
  @JsonKey(name: 'mother_father_feeling')
  String? get motherFatherFeeling => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_schedule_date')
  String? get birthScheduleDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildModelCopyWith<ChildModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildModelCopyWith<$Res> {
  factory $ChildModelCopyWith(
          ChildModel value, $Res Function(ChildModel) then) =
      _$ChildModelCopyWithImpl<$Res, ChildModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'baby_id') int? babyId,
      String nickname,
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
      @JsonKey(name: 'birth_schedule_date') String? birthScheduleDate});
}

/// @nodoc
class _$ChildModelCopyWithImpl<$Res, $Val extends ChildModel>
    implements $ChildModelCopyWith<$Res> {
  _$ChildModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? babyId = freezed,
    Object? nickname = null,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? monthFromBirth = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? headMeasurement = freezed,
    Object? chestMeasurement = freezed,
    Object? birthPlace = freezed,
    Object? birthDoctor = freezed,
    Object? motherFatherFeeling = freezed,
    Object? message = freezed,
    Object? comment = freezed,
    Object? birthScheduleDate = freezed,
  }) {
    return _then(_value.copyWith(
      babyId: freezed == babyId
          ? _value.babyId
          : babyId // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      monthFromBirth: freezed == monthFromBirth
          ? _value.monthFromBirth
          : monthFromBirth // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      headMeasurement: freezed == headMeasurement
          ? _value.headMeasurement
          : headMeasurement // ignore: cast_nullable_to_non_nullable
              as double?,
      chestMeasurement: freezed == chestMeasurement
          ? _value.chestMeasurement
          : chestMeasurement // ignore: cast_nullable_to_non_nullable
              as double?,
      birthPlace: freezed == birthPlace
          ? _value.birthPlace
          : birthPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDoctor: freezed == birthDoctor
          ? _value.birthDoctor
          : birthDoctor // ignore: cast_nullable_to_non_nullable
              as String?,
      motherFatherFeeling: freezed == motherFatherFeeling
          ? _value.motherFatherFeeling
          : motherFatherFeeling // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      birthScheduleDate: freezed == birthScheduleDate
          ? _value.birthScheduleDate
          : birthScheduleDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChildModelCopyWith<$Res>
    implements $ChildModelCopyWith<$Res> {
  factory _$$_ChildModelCopyWith(
          _$_ChildModel value, $Res Function(_$_ChildModel) then) =
      __$$_ChildModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'baby_id') int? babyId,
      String nickname,
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
      @JsonKey(name: 'birth_schedule_date') String? birthScheduleDate});
}

/// @nodoc
class __$$_ChildModelCopyWithImpl<$Res>
    extends _$ChildModelCopyWithImpl<$Res, _$_ChildModel>
    implements _$$_ChildModelCopyWith<$Res> {
  __$$_ChildModelCopyWithImpl(
      _$_ChildModel _value, $Res Function(_$_ChildModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? babyId = freezed,
    Object? nickname = null,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? monthFromBirth = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? headMeasurement = freezed,
    Object? chestMeasurement = freezed,
    Object? birthPlace = freezed,
    Object? birthDoctor = freezed,
    Object? motherFatherFeeling = freezed,
    Object? message = freezed,
    Object? comment = freezed,
    Object? birthScheduleDate = freezed,
  }) {
    return _then(_$_ChildModel(
      babyId: freezed == babyId
          ? _value.babyId
          : babyId // ignore: cast_nullable_to_non_nullable
              as int?,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as int?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      monthFromBirth: freezed == monthFromBirth
          ? _value.monthFromBirth
          : monthFromBirth // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      headMeasurement: freezed == headMeasurement
          ? _value.headMeasurement
          : headMeasurement // ignore: cast_nullable_to_non_nullable
              as double?,
      chestMeasurement: freezed == chestMeasurement
          ? _value.chestMeasurement
          : chestMeasurement // ignore: cast_nullable_to_non_nullable
              as double?,
      birthPlace: freezed == birthPlace
          ? _value.birthPlace
          : birthPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDoctor: freezed == birthDoctor
          ? _value.birthDoctor
          : birthDoctor // ignore: cast_nullable_to_non_nullable
              as String?,
      motherFatherFeeling: freezed == motherFatherFeeling
          ? _value.motherFatherFeeling
          : motherFatherFeeling // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      birthScheduleDate: freezed == birthScheduleDate
          ? _value.birthScheduleDate
          : birthScheduleDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChildModel implements _ChildModel {
  const _$_ChildModel(
      {@JsonKey(name: 'baby_id') required this.babyId,
      this.nickname = '',
      this.gender,
      this.birthday,
      @JsonKey(name: 'month_from_birth') this.monthFromBirth,
      this.height,
      this.weight,
      @JsonKey(name: 'head_measurement') this.headMeasurement,
      @JsonKey(name: 'chest_measurement') this.chestMeasurement,
      @JsonKey(name: 'birth_place') this.birthPlace,
      @JsonKey(name: 'birth_doctor') this.birthDoctor,
      @JsonKey(name: 'mother_father_feeling') this.motherFatherFeeling,
      this.message,
      this.comment,
      @JsonKey(name: 'birth_schedule_date') this.birthScheduleDate});

  factory _$_ChildModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChildModelFromJson(json);

  @override
  @JsonKey(name: 'baby_id')
  final int? babyId;
  @override
  @JsonKey()
  final String nickname;
  @override
  final int? gender;
  @override
  final String? birthday;
  @override
  @JsonKey(name: 'month_from_birth')
  final int? monthFromBirth;
  @override
  final double? height;
  @override
  final double? weight;
  @override
  @JsonKey(name: 'head_measurement')
  final double? headMeasurement;
  @override
  @JsonKey(name: 'chest_measurement')
  final double? chestMeasurement;
  @override
  @JsonKey(name: 'birth_place')
  final String? birthPlace;
  @override
  @JsonKey(name: 'birth_doctor')
  final String? birthDoctor;
  @override
  @JsonKey(name: 'mother_father_feeling')
  final String? motherFatherFeeling;
  @override
  final String? message;
  @override
  final String? comment;
  @override
  @JsonKey(name: 'birth_schedule_date')
  final String? birthScheduleDate;

  @override
  String toString() {
    return 'ChildModel(babyId: $babyId, nickname: $nickname, gender: $gender, birthday: $birthday, monthFromBirth: $monthFromBirth, height: $height, weight: $weight, headMeasurement: $headMeasurement, chestMeasurement: $chestMeasurement, birthPlace: $birthPlace, birthDoctor: $birthDoctor, motherFatherFeeling: $motherFatherFeeling, message: $message, comment: $comment, birthScheduleDate: $birthScheduleDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildModel &&
            (identical(other.babyId, babyId) || other.babyId == babyId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.monthFromBirth, monthFromBirth) ||
                other.monthFromBirth == monthFromBirth) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.headMeasurement, headMeasurement) ||
                other.headMeasurement == headMeasurement) &&
            (identical(other.chestMeasurement, chestMeasurement) ||
                other.chestMeasurement == chestMeasurement) &&
            (identical(other.birthPlace, birthPlace) ||
                other.birthPlace == birthPlace) &&
            (identical(other.birthDoctor, birthDoctor) ||
                other.birthDoctor == birthDoctor) &&
            (identical(other.motherFatherFeeling, motherFatherFeeling) ||
                other.motherFatherFeeling == motherFatherFeeling) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.birthScheduleDate, birthScheduleDate) ||
                other.birthScheduleDate == birthScheduleDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      babyId,
      nickname,
      gender,
      birthday,
      monthFromBirth,
      height,
      weight,
      headMeasurement,
      chestMeasurement,
      birthPlace,
      birthDoctor,
      motherFatherFeeling,
      message,
      comment,
      birthScheduleDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildModelCopyWith<_$_ChildModel> get copyWith =>
      __$$_ChildModelCopyWithImpl<_$_ChildModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChildModelToJson(
      this,
    );
  }
}

abstract class _ChildModel implements ChildModel {
  const factory _ChildModel(
      {@JsonKey(name: 'baby_id')
          required final int? babyId,
      final String nickname,
      final int? gender,
      final String? birthday,
      @JsonKey(name: 'month_from_birth')
          final int? monthFromBirth,
      final double? height,
      final double? weight,
      @JsonKey(name: 'head_measurement')
          final double? headMeasurement,
      @JsonKey(name: 'chest_measurement')
          final double? chestMeasurement,
      @JsonKey(name: 'birth_place')
          final String? birthPlace,
      @JsonKey(name: 'birth_doctor')
          final String? birthDoctor,
      @JsonKey(name: 'mother_father_feeling')
          final String? motherFatherFeeling,
      final String? message,
      final String? comment,
      @JsonKey(name: 'birth_schedule_date')
          final String? birthScheduleDate}) = _$_ChildModel;

  factory _ChildModel.fromJson(Map<String, dynamic> json) =
      _$_ChildModel.fromJson;

  @override
  @JsonKey(name: 'baby_id')
  int? get babyId;
  @override
  String get nickname;
  @override
  int? get gender;
  @override
  String? get birthday;
  @override
  @JsonKey(name: 'month_from_birth')
  int? get monthFromBirth;
  @override
  double? get height;
  @override
  double? get weight;
  @override
  @JsonKey(name: 'head_measurement')
  double? get headMeasurement;
  @override
  @JsonKey(name: 'chest_measurement')
  double? get chestMeasurement;
  @override
  @JsonKey(name: 'birth_place')
  String? get birthPlace;
  @override
  @JsonKey(name: 'birth_doctor')
  String? get birthDoctor;
  @override
  @JsonKey(name: 'mother_father_feeling')
  String? get motherFatherFeeling;
  @override
  String? get message;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'birth_schedule_date')
  String? get birthScheduleDate;
  @override
  @JsonKey(ignore: true)
  _$$_ChildModelCopyWith<_$_ChildModel> get copyWith =>
      throw _privateConstructorUsedError;
}
