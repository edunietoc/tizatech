import 'package:flutter/material.dart';

import '../models/login_data.dart';
import '../models/user.dart';

class UserService {
  UserService() {
    user = User();
  }
  User user;

  LoginData loginData = LoginData();

  UserType get getUserType {
    const Map<int, UserType> userMap = <int, UserType>{
      0: UserType.admin,
      1: UserType.student,
      2: UserType.parent,
      3: UserType.teacher,
    };
    return userMap[loginData.userType];
  }

  Widget getUserAvatar({User userParam}) {
    UserType _userType = userParam != null
        ? UserType.values[userParam.userType]
        : UserType.values[loginData.userType];
    String _picturePath =
        userParam != null ? userParam.picturePath : user.picturePath;

    User _user = userParam ?? user;

    switch (_userType) {
      case UserType.admin:
        return Container();
      case UserType.student:
        if (_picturePath ==
            'http://tizatechapp-demo.herokuapp.com/media/default.jpg') {
          switch (_user.gender) {
            case Gender.femenino:
              return Image.asset('assets/images/avatars/girl.png');
              break;
            case Gender.masculino:
              return Image.asset('assets/images/avatars/boy.png');
          }
        } else {
          return Image.network(user.picturePath);
        }

        break;
      case UserType.parent:
        if (_picturePath ==
            'http://tizatechapp-demo.herokuapp.com/media/default.jpg') {
          switch (_user.gender) {
            case Gender.femenino:
              return Image.asset('assets/images/avatars/woman.png');
              break;
            case Gender.masculino:
              return Image.asset('assets/images/avatars/man.png');
          }
        } else {
          return Image.network(user.picturePath);
        }
        break;
      case UserType.teacher:
        if (_picturePath ==
            'http://tizatechapp-demo.herokuapp.com/media/default.jpg') {
          switch (_user.gender) {
            case Gender.femenino:
              return Image.asset('assets/images/avatars/woman.png');
              break;
            case Gender.masculino:
              return Image.asset('assets/images/avatars/man.png');
          }
        } else {
          return Image.network(user.picturePath);
        }
        break;
      default:
        return null;
    }
  }

  String userTypeString({User userParam}) {
    UserType _userType = userParam != null
        ? UserType.values[userParam.userType]
        : UserType.values[loginData.userType];

    const Map<UserType, String> _userMap = <UserType, String>{
      UserType.admin: 'Admin',
      UserType.student: 'Alumno',
      UserType.parent: 'Apoderado',
      UserType.teacher: 'Profesor',
    };

    return _userMap[_userType];
  }

  bool get isAvatarPictureDefault =>
      user.picturePath ==
      'http://tizatechapp-demo.herokuapp.com/media/default.jpg';
}

enum UserType {
  admin,
  student,
  parent,
  teacher,
}
