import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../globals.dart' as globals;

////////////////////////////////
/////////// TOKEN /////////////
//////////////////////////////

@JsonSerializable()
class UsersAuth {
  const UsersAuth({
    required this.id,
    required this.token,
  });

  // factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  // Map<String, dynamic> toJson() => _$UserseToJson(this);
  // factory Users.fromJson(Map<String, dynamic> json) {
  //   return Users(
  //     id: json["id"],
  //     username: json['username'],
  //     confirm: json['confirm'],
  //     email: json['email'],
  //     password: json['password'],
  //     date: json['date'],
  //     token: json['token'],
  //     country: json['country'],
  //   );
  // }
  factory UsersAuth.fromJson(Map<String, dynamic> json) {
    return UsersAuth(
      token: json['token'],
      id: json["id"],
    );
  }

  final String token;
  final String id;
}

////////////////////////////////////
/////////// USER INFO /////////////
//////////////////////////////////

@JsonSerializable()
class UserInfo {
  const UserInfo({
    required this.username,
    required this.confirm,
    required this.email,
    required this.password,
    required this.date,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      username: json['username'],
      confirm: json['confirm'],
      email: json['email'],
      password: json['password'],
      date: json['date'],
    );
  }

  final String username;
  final bool confirm;
  final String email;
  final String password;
  final String date;
}