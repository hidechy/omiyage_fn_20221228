import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '/data/http/path.dart';
import '/data/local/local_client.dart';
import '/environment.dart';
import 'exception/exception.dart';

final Provider<IHSHttpClient> httpClientProvider = Provider<IHSHttpClient>(
  (ProviderRef<IHSHttpClient> ref) => IHSHttpClient(
    client: Client(),
    localClient: ref.watch(localClientProvider),
  ),
);

class IHSHttpClient {
  IHSHttpClient({
    required this.client,
    required this.localClient,
  });

  final Client client;
  final LocalClient localClient;

  Future<Map<String, dynamic>> post(
    IHSAPIPath path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    // TODO(miura): テスト環境->http, 本番->httpsに向き先を変える
    final uri = Uri.http(
      Environment.apiEndPoint,
      '${Environment.apiBasePath}/${path.value}',
      await _generateParameters(path, queryParameters),
    );

    final response = await client.post(
      uri,
      headers: _headers,
      body: json.encode(body),
    );

    debugPrint(response.request.toString());
    debugPrint('Status Code: ${response.statusCode.toString()}');
    debugPrint(response.body);

    if (!response.ok) {
      switch (response.statusCode) {
        case 503:
          throw const HttpStatusException.maintenanceMode(
              msg: 'Maintenance Mode');
        default:
          throw const HttpStatusException.other(msg: 'Status Code Error');
      }
    }

    try {
      final bodyString = utf8.decode(response.bodyBytes);
      return jsonDecode(bodyString) as Map<String, dynamic>;
    } on Exception catch (_) {
      throw Exception('json parse error');
    }
  }

  Future<Map<String, dynamic>> _generateParameters(
      IHSAPIPath path, Map<String, dynamic>? queryParameters) async {
    final params = queryParameters ?? {};

    if (path.needCredentialsInHeader) {
      final userId = await localClient.get<int>(LocalKeyType.userId);
      final accessToken =
          await localClient.get<String>(LocalKeyType.accessToken);

      if (userId == null || accessToken == null) {
        throw Exception('認証情報がローカルに保存されていません');
      }

      params['user_id'] = userId.toString();
      params['access_token'] = accessToken;
    }

    return params;
  }

  Map<String, String> get _headers {
    return {'content-type': 'application/json'};
  }
}

extension ResponseEx on Response {
  bool get ok => (statusCode ~/ 100) == 2;
}
