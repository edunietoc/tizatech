import 'dart:convert';

import 'package:http/http.dart' as http;

import '../locator/locator.dart';
import '../locator/user_service.dart';
import '../models/login_data.dart';

class API {
  final String _url = 'http://tizatechapp-demo.herokuapp.com/api/';

  Map<String, String> _getHeaders() {
    LoginData loginData = locator<UserService>().loginData;

    return (loginData.token != null && loginData.token.isNotEmpty)
        ? <String, String>{
            'Authorization': 'Token ${loginData.token}',
          }
        : null;
  }

  Future<dynamic> getRequest(String endpoint) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{};

    headers.addAll({
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    Uri url = Uri.parse(_url + endpoint);
    try {
      http.Response response = await http.get(url, headers: headers);

      dynamic map = json.decode(utf8.decode(response.bodyBytes));

      return map;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    Map<String, String> headers = _getHeaders() ?? <String, String>{};
    Uri url = Uri.parse(_url + endpoint);
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
}
