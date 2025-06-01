import 'dart:convert';
import 'package:animelagoom/core/api/api_constatnts.dart';
import 'package:http/http.dart' as http;

class KitsuApiManager {
  final String? accessToken;

  const KitsuApiManager({this.accessToken});

  /// 🔍 Unified GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '${KitsuApiConstants.baseUrl}$endpoint',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _headers());

    return _handleResponse(response) as Map<String, dynamic>;
  }

  /// ✏️ Unified POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.post(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// 🛠 Generic PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.put(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// 🗑 DELETE request
  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.delete(uri, headers: _headers());

    return _handleResponse(response);
  }

  /// 🧾 Header Builder
  Map<String, String> _headers() {
    return {
      ...KitsuApiConstants.defaultHeaders,
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }

  /// 🎯 Response Validator + Extractor
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final json = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return json;
    } else {
      // Optionally wrap this into a custom error class
      throw Exception(
        'API Error [$statusCode]: ${json['errors'] ?? response.reasonPhrase}',
      );
    }
  }
}
