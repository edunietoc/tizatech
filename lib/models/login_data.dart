import 'dart:convert';

class LoginData {
  LoginData({
    this.id,
    this.token,
    this.userType,
  });

  factory LoginData.fromMap(Map<String, dynamic> map) => LoginData(
        token: map['token'],
        id: map['user_id'],
        userType: map['user_type'],
      );

  factory LoginData.fromJson(String source) =>
      LoginData.fromMap(json.decode(source));

  String token;
  int id;
  int userType;
/* 
  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'id': id,
      };

  String toJson() => json.encode(toMap()); */
}
