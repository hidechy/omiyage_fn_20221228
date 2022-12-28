import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/notice_category/model.dart';
import '../../../data/model/notice_list/model.dart';

part 'state.freezed.dart';

@freezed
class InfomationSelectState with _$InfomationSelectState {
  // ローディング中
  const factory InfomationSelectState.loading() = InfomationSelectStateLoading;

  const factory InfomationSelectState.loaded({
    @Default([]) List<CategoryItemModel> categories,
    @Default([]) List<NoticeListItemModel> notices,
    @Default(1) int page,
    int? selectedCategoryId,
    @Default(true) bool hasOldNotices,
    @Default(false) bool loading,
  }) = InfomationSelectStateLoaded;
}
