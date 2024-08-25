import 'package:flutter/widgets.dart';

class AuthCredentials {
  final String accessToken;
  final String refreshToken;

  const AuthCredentials(
      {required this.accessToken, required this.refreshToken});

  factory AuthCredentials.fromJson(Map<String, dynamic> json) {
    // print(json.toString());
    return AuthCredentials(
        accessToken: json['access_token'], refreshToken: json['refresh_token']);
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}

class AuthFields {
  final String? username;
  final String? email;
  final String? password;

  const AuthFields(
      {required this.username, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'username': username, 'password': password};
  }
}
