import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './users.dart' as users;
import 'package:flutter/material.dart';


import '../../globals.dart' as globals;

////////////////////////////////
/////////// TOKEN /////////////
//////////////////////////////

Future<bool> userLogin(String email, String password) async {
  await dotenv.load(fileName: '.env');
  final response = await http.post(
    Uri.parse('${dotenv.env['API_URL'].toString()}/auth'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );
  if (response.statusCode == 201) {
    var userAuth = users.UsersAuth.fromJson(jsonDecode(response.body));
    globals.token = userAuth.token;
    globals.userId = userAuth.id;
    return true;
  } else {
    throw Exception("Loging failure");
  }
}

Future<bool> userRegister(
    String username, String email, String password) async {
  await dotenv.load(fileName: '.env');
  final response = await http.post(
    Uri.parse('${dotenv.env['API_URL'].toString()}/user'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
        {'username': username, 'email': email, 'password': password}),
  );
  if (response.statusCode == 201) {
    var userAuth = users.UsersAuth.fromJson(jsonDecode(response.body));
    globals.token = userAuth.token;
    globals.userId = userAuth.id;
    return true;
  } else {
    throw Exception("Registry failure");
  }
}

////////////////////////////////////
/////////// USER INFO /////////////
//////////////////////////////////

Future<users.UserInfo> getUserInfo() async {
  await dotenv.load(fileName: '.env');
  final response = await http.get(
    Uri.parse('${dotenv.env['API_URL'].toString()}/user'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': globals.token,
    },
  );
  if (response.statusCode == 200) {
    var userInfo = users.UserInfo.fromJson(jsonDecode(response.body));
    globals.username = userInfo.username;
    globals.email = userInfo.email;
    return userInfo;
  } else {
    throw Exception('Failed to get user.');
  }
}

Future<bool> registerSpotify(String token) async {
  await dotenv.load(fileName: '.env');
  final response = await http.post(
    Uri.parse('${dotenv.env['API_URL'].toString()}/userSpotify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'token': token,
    }),
  );
  if (response.statusCode == 201) {
    var userAuth = users.UsersAuth.fromJson(jsonDecode(response.body));
    globals.token = userAuth.token;
    globals.userId = userAuth.id;
    return true;
  } else {
    throw Exception('Failed to register user with spotify.');
  }
}

Future<bool> loginSpotify(String token) async {
  await dotenv.load(fileName: '.env');
  final response = await http.post(
    Uri.parse('${dotenv.env['API_URL'].toString()}/authSpotify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'token': token,
    }),
  );
  debugPrint("\n\n\nresponce "+response.statusCode.toString()+" : "+response.body.toString());
  if (response.statusCode == 200) {
    var userAuth = users.UsersAuth.fromJson(jsonDecode(response.body));
    globals.token = userAuth.token;
    globals.userId = userAuth.id;
    return true;
  } else {
    throw Exception('Failed to login user with spotify.');
  }
}