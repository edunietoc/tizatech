import 'api.dart';

class AuthService {
  API api = API();
  Future<String> login(String email, String password) async {
    const String endpoint = 'api-token-auth/';
    try {
      Map<String, dynamic> response = await api.post(endpoint, <String, String>{
        'username': email,
        'password': password,
      });
      if (response.containsKey('token')) {
        return response['token'];
      } else {
        throw Exception(response.values.last.toString());
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
