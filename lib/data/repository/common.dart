import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/http/client.dart';
import '/data/http/path.dart';
import '/data/model/response/model.dart';
import '../model/consent/model.dart';
import '../request/consent/request.dart';

/// 汎用Repository
abstract class CommonRepository {
  /// 共通コンフィグ取得
  //TODO(miura): 返ってくるレスポンスが確定したら、Mapでなく型でレスポンスを表現する
  Future<IHSResponse<Map<String, dynamic>>> fetchConfig();

  /// 同意内容取得
  Future<IHSResponse<ConsentListModel>> fetchConsentContents();

  /// ユーザー同意内容取得
  Future<IHSResponse<ConsentListModel>> fetchUserConsentContents();

  /// ユーザー同意内容更新
  Future<IHSResponse<Empty>> updateConsentContents({
    required ConsentContentsConsentRequest request,
  });
}

class CommonRepositoryImpl implements CommonRepository {
  CommonRepositoryImpl({
    required this.client,
  });

  final IHSHttpClient client;

  @override
  Future<IHSResponse<Map<String, dynamic>>> fetchConfig() async {
    final response = await client.post(
      IHSAPIPath.config,
    );
    return IHSResponse<Map<String, dynamic>>.fromJson(
      response,
      (Object? json) {
        if (response['data'] == null) {
          return {};
        }
        return json! as Map<String, dynamic>;
      },
    );
  }

  @override
  Future<IHSResponse<ConsentListModel>> fetchConsentContents() async {
    final response = await client.post(
      IHSAPIPath.consentContents,
    );
    return IHSResponse<ConsentListModel>.fromJson(
      response,
      (Object? json) {
        if (response['data'] == null) {
          return const ConsentListModel(list: []);
        }
        return ConsentListModel.fromJson(json! as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<IHSResponse<ConsentListModel>> fetchUserConsentContents() async {
    final response = await client.post(
      IHSAPIPath.consentContentsNewer,
    );
    return IHSResponse<ConsentListModel>.fromJson(
      response,
      (Object? json) {
        if (response['data'] == null) {
          return const ConsentListModel(list: []);
        }

        return ConsentListModel.fromJson(json! as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<IHSResponse<Empty>> updateConsentContents({
    required ConsentContentsConsentRequest request,
  }) async {
    final response = await client.post(
      IHSAPIPath.consentContentsConsent,
      body: request.toJson(),
    );
    return IHSResponse<ConsentListModel>.fromJson(
      response,
      (Object? json) => null,
    );
  }
}

final Provider<CommonRepository> commonRepositoryProvider =
    Provider<CommonRepository>(
  (ProviderRef<CommonRepository> ref) {
    final client = ref.read(httpClientProvider);
    return CommonRepositoryImpl(
      client: client,
    );
  },
);
