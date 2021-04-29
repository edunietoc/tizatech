import '../locator/locator.dart';
import '../locator/user_service.dart';
import '../models/login_data.dart';
import '../models/user.dart';
import 'api.dart';

class AuthService {
  API api = API();
  Future<void> login(String email, String password) async {
    const String endpoint = 'api-token-auth/';
    try {
      Map<String, dynamic> response = await api.post(endpoint, <String, String>{
        'username': email,
        'password': password,
      });
      if (response.containsKey('token')) {
        UserService userService = locator<UserService>()
          ..loginData = LoginData.fromMap(response);

        Map<String, dynamic> userMap = await getProfileData(
            userService.getUserType, userService.loginData.id);

        if (userService.getUserType == UserType.student) {
          userService.user = Student.fromMap(userMap);
        } else if (userService.getUserType == UserType.parent) {
          userService.user = Parent.fromMap(userMap);
        }
      } else {
        throw Exception(response.values.last.toString());
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProfileData(UserType type, int id) async {
    try {
      String endpoint;

      if (type == UserType.student) {
        endpoint = 'alumnos/$id/';
      } else if (type == UserType.parent) {
        endpoint = 'apoderados/$id/';
      }
      Map<String, dynamic> response = await api.getRequest(endpoint);
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
