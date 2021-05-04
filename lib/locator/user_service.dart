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

  Widget getUserAvatar({User userParam}) {
    UserType _userType = userParam != null
        ? UserType.values[userParam.userType]
        : UserType.values[loginData.userType];
    String _picturePath =
        userParam != null ? userParam.picturePath : user.picturePath;

    switch (_userType) {
      case UserType.admin:
        return Container();
      case UserType.student:
        if (_picturePath ==
            'http://tizatechapp-demo.herokuapp.com/media/default.jpg') {
          switch (user.gender) {
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
          switch (user.gender) {
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
        return Container();
      default:
        return null;
    }
  }

  String userTypeString({User userParam}) {
    UserType _userType = userParam != null
        ? UserType.values[userParam.userType]
        : UserType.values[loginData.userType];

    switch (_userType) {
      case UserType.admin:
        return 'Admin';
      case UserType.student:
        return 'Alumno';
      case UserType.parent:
        return 'Apoderado';
      case UserType.teacher:
        return 'Profesor';
      default:
        return '';
    }
  }

  bool get isAvatarPictureDefault {
    if (user.picturePath ==
        'http://tizatechapp-demo.herokuapp.com/media/default.jpg') {
      print('is true');
      return true;
    } else {
      print('is false');
      return false;
    }
  }
}

enum UserType {
  admin,
  student,
  parent,
  teacher,
}
