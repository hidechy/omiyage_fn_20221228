import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

/// 同意内容取得APIから返却されるデータモデル
@freezed
class ConsentListModel with _$ConsentListModel {
  const factory ConsentListModel({
    @Default([]) List<ConsentModel> list,
  }) = _ConsentListModel;

  factory ConsentListModel.fromJson(Map<String, dynamic> json) {
    final list = <ConsentModel>[];

    final contentMap = json['list'] as Map<String, dynamic>;

    for (final key in contentMap.keys) {
      if (contentMap[key] == null) {
        continue;
      }

      final id = (contentMap[key] as Map<String, dynamic>)['id'] as int;
      final title =
          (contentMap[key] as Map<String, dynamic>)['title'] as String;
      final content =
          (contentMap[key] as Map<String, dynamic>)['content'] as String;
      switch (key) {
        case 'privacy_policy_consent_id':
          list.add(ConsentModel.poricy(id: id, title: title, content: content));
          break;
        case 'privacy_protection_consent_id':
          list.add(
              ConsentModel.individual(id: id, title: title, content: content));
          break;
        case 'service_terms_consent_id':
          list.add(ConsentModel.terms(id: id, title: title, content: content));
          break;
        default:
      }
    }

    return ConsentListModel(list: list);
  }
}

@freezed
class ConsentModel with _$ConsentModel {
  /// プライバシーポリシー
  const factory ConsentModel.poricy({
    required int id,
    required String title,
    required String content,
  }) = PoricyConsentModel;

  /// 個人情報保護方針
  const factory ConsentModel.individual({
    required int id,
    required String title,
    required String content,
  }) = IndividualConsentModel;

  /// 規約
  const factory ConsentModel.terms({
    required int id,
    required String title,
    required String content,
  }) = TermsConsentModel;

  factory ConsentModel.fromJson(Map<String, dynamic> json) =>
      _$ConsentModelFromJson(json);
}

extension ConsentModelEx on ConsentModel {
  String get label {
    return map(
      poricy: (_) => 'プライバシーポリシー',
      individual: (_) => '個人情報保護方針',
      terms: (_) => '利用規約',
    );
  }

  int get type {
    return map(
      poricy: (_) => 1,
      individual: (_) => 2,
      terms: (_) => 3,
    );
  }
}
