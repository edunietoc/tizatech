import '../models/login_data.dart';
import '../models/user.dart';

class UserService {
  UserService() {
    user = User();
  }
  User user;

  LoginData loginData = LoginData();

  UserType get getUserType {
    switch (loginData.userType) {
      case 0:
        return UserType.admin;
      case 1:
        return UserType.student;
      case 2:
        return UserType.parent;
      case 3:
        return UserType.teacher;
      default:
        return null;
    }
  }
}

enum UserType {
  admin,
  student,
  parent,
  teacher,
}
