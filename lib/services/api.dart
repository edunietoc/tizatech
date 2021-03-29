import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  final String _url = 'http://tizatech.herokuapp.com/api/';

  Future<Map<String, dynamic>> get(String endpoint) async {
    /* Uri url = Uri.http(_url, endpoint); */
    Uri url = Uri.parse(_url + endpoint);
    try {
      http.Response response = await http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    /* Uri url = Uri.http(_url, endpoint); */
    Uri url = Uri.parse(_url + endpoint);
    try {
      http.Response response = await http.post(url, body: body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return json;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
