import 'dart:convert';

import 'package:http/http.dart' as http;

import '../locator/locator.dart';
import '../locator/user_service.dart';
import '../models/login_data.dart';
import '../shared/api.dart';

class API {
  Map<String, String> _getHeaders() {
    LoginData loginData = locator<UserService>().loginData;

    return (loginData.token != null && loginData.token.isNotEmpty)
        ? <String, String>{
            'Authorization': 'Token ${loginData.token}',
          }
        : null;
  }

  Future<dynamic> getRequest(String endpoint) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{}
      ..addAll(<String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      http.Response response = await http.get(url, headers: headers);

      dynamic map = json.decode(utf8.decode(response.bodyBytes));

      return map;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<dynamic> getRequestWithParams(
      String baseUrl, Map<String, dynamic> parameters, String endpoint,
      {bool isHttps = true}) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{}
      ..addAll(<String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

    Uri url = isHttps
        ? Uri.https(baseUrl, endpoint, parameters)
        : Uri.http(baseUrl, endpoint, parameters);

    try {
      http.Response response = await http.get(url, headers: headers);

      dynamic map = json.decode(utf8.decode(response.bodyBytes));

      return map;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic body) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{};
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      http.Response response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic body) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{}
      ..addAll(<String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      http.Response response = await http.put(
        url,
        body: body,
        headers: headers,
      );
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> putRequest(String endpoint, dynamic body) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{}
      ..addAll(<String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      http.Request request = http.Request('PUT', url)
        ..body = body
        ..headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String data = utf8.decode(await response.stream.single);
      return json.decode(data);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
