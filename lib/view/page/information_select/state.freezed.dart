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
mixin _$InfomationSelectState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InfomationSelectStateLoading value) loading,
    required TResult Function(InfomationSelectStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InfomationSelectStateLoading value)? loading,
    TResult? Function(InfomationSelectStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InfomationSelectStateLoading value)? loading,
    TResult Function(InfomationSelectStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfomationSelectStateCopyWith<$Res> {
  factory $InfomationSelectStateCopyWith(InfomationSelectState value,
          $Res Function(InfomationSelectState) then) =
      _$InfomationSelectStateCopyWithImpl<$Res, InfomationSelectState>;
}

/// @nodoc
class _$InfomationSelectStateCopyWithImpl<$Res,
        $Val extends InfomationSelectState>
    implements $InfomationSelectStateCopyWith<$Res> {
  _$InfomationSelectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InfomationSelectStateLoadingCopyWith<$Res> {
  factory _$$InfomationSelectStateLoadingCopyWith(
          _$InfomationSelectStateLoading value,
          $Res Function(_$InfomationSelectStateLoading) then) =
      __$$InfomationSelectStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InfomationSelectStateLoadingCopyWithImpl<$Res>
    extends _$InfomationSelectStateCopyWithImpl<$Res,
        _$InfomationSelectStateLoading>
    implements _$$InfomationSelectStateLoadingCopyWith<$Res> {
  __$$InfomationSelectStateLoadingCopyWithImpl(
      _$InfomationSelectStateLoading _value,
      $Res Function(_$InfomationSelectStateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InfomationSelectStateLoading implements InfomationSelectStateLoading {
  const _$InfomationSelectStateLoading();

  @override
  String toString() {
    return 'InfomationSelectState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfomationSelectStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InfomationSelectStateLoading value) loading,
    required TResult Function(InfomationSelectStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InfomationSelectStateLoading value)? loading,
    TResult? Function(InfomationSelectStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InfomationSelectStateLoading value)? loading,
    TResult Function(InfomationSelectStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class InfomationSelectStateLoading implements InfomationSelectState {
  const factory InfomationSelectStateLoading() = _$InfomationSelectStateLoading;
}

/// @nodoc
abstract class _$$InfomationSelectStateLoadedCopyWith<$Res> {
  factory _$$InfomationSelectStateLoadedCopyWith(
          _$InfomationSelectStateLoaded value,
          $Res Function(_$InfomationSelectStateLoaded) then) =
      __$$InfomationSelectStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<CategoryItemModel> categories,
      List<NoticeListItemModel> notices,
      int page,
      int? selectedCategoryId,
      bool hasOldNotices,
      bool loading});
}

/// @nodoc
class __$$InfomationSelectStateLoadedCopyWithImpl<$Res>
    extends _$InfomationSelectStateCopyWithImpl<$Res,
        _$InfomationSelectStateLoaded>
    implements _$$InfomationSelectStateLoadedCopyWith<$Res> {
  __$$InfomationSelectStateLoadedCopyWithImpl(
      _$InfomationSelectStateLoaded _value,
      $Res Function(_$InfomationSelectStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? notices = null,
    Object? page = null,
    Object? selectedCategoryId = freezed,
    Object? hasOldNotices = null,
    Object? loading = null,
  }) {
    return _then(_$InfomationSelectStateLoaded(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryItemModel>,
      notices: null == notices
          ? _value._notices
          : notices // ignore: cast_nullable_to_non_nullable
              as List<NoticeListItemModel>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCategoryId: freezed == selectedCategoryId
          ? _value.selectedCategoryId
          : selectedCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      hasOldNotices: null == hasOldNotices
          ? _value.hasOldNotices
          : hasOldNotices // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InfomationSelectStateLoaded implements InfomationSelectStateLoaded {
  const _$InfomationSelectStateLoaded(
      {final List<CategoryItemModel> categories = const [],
      final List<NoticeListItemModel> notices = const [],
      this.page = 1,
      this.selectedCategoryId,
      this.hasOldNotices = true,
      this.loading = false})
      : _categories = categories,
        _notices = notices;

  final List<CategoryItemModel> _categories;
  @override
  @JsonKey()
  List<CategoryItemModel> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<NoticeListItemModel> _notices;
  @override
  @JsonKey()
  List<NoticeListItemModel> get notices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notices);
  }

  @override
  @JsonKey()
  final int page;
  @override
  final int? selectedCategoryId;
  @override
  @JsonKey()
  final bool hasOldNotices;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'InfomationSelectState.loaded(categories: $categories, notices: $notices, page: $page, selectedCategoryId: $selectedCategoryId, hasOldNotices: $hasOldNotices, loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfomationSelectStateLoaded &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._notices, _notices) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(other.hasOldNotices, hasOldNotices) ||
                other.hasOldNotices == hasOldNotices) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_notices),
      page,
      selectedCategoryId,
      hasOldNotices,
      loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InfomationSelectStateLoadedCopyWith<_$InfomationSelectStateLoaded>
      get copyWith => __$$InfomationSelectStateLoadedCopyWithImpl<
          _$InfomationSelectStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)
        loaded,
  }) {
    return loaded(categories, notices, page, selectedCategoryId, hasOldNotices,
        this.loading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
  }) {
    return loaded?.call(categories, notices, page, selectedCategoryId,
        hasOldNotices, this.loading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<CategoryItemModel> categories,
            List<NoticeListItemModel> notices,
            int page,
            int? selectedCategoryId,
            bool hasOldNotices,
            bool loading)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(categories, notices, page, selectedCategoryId,
          hasOldNotices, this.loading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InfomationSelectStateLoading value) loading,
    required TResult Function(InfomationSelectStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InfomationSelectStateLoading value)? loading,
    TResult? Function(InfomationSelectStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InfomationSelectStateLoading value)? loading,
    TResult Function(InfomationSelectStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class InfomationSelectStateLoaded implements InfomationSelectState {
  const factory InfomationSelectStateLoaded(
      {final List<CategoryItemModel> categories,
      final List<NoticeListItemModel> notices,
      final int page,
      final int? selectedCategoryId,
      final bool hasOldNotices,
      final bool loading}) = _$InfomationSelectStateLoaded;

  List<CategoryItemModel> get categories;
  List<NoticeListItemModel> get notices;
  int get page;
  int? get selectedCategoryId;
  bool get hasOldNotices;
  bool get loading;
  @JsonKey(ignore: true)
  _$$InfomationSelectStateLoadedCopyWith<_$InfomationSelectStateLoaded>
      get copyWith => throw _privateConstructorUsedError;
}
