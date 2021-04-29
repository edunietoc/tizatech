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

  Widget get getUserAvatar {
    switch (loginData.userType) {
      case 0:
        return Container();
      case 1:
        if (user.picturePath ==
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
      case 2:
        if (user.picturePath ==
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
      case 3:
        return Container();
      default:
        return null;
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
