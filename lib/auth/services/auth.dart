import 'package:campus_connect_frontend/messaging/messaging.dart';
import 'package:campus_connect_frontend/notifications/notifications.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../models/auth_cred.dart';

abstract class AuthService {
  String get loginUrl;
  String get registerUrl;
  String get passwordResetUrl;

  StorageService get storage;
  String get storageKey;

  APIService get apiService;

  AuthCredentials? _credentials;

  Future<bool> get isLogedIn async => await credentials != null;

  Future<void> init() async {
    await credentials;
  }

  Future<AuthCredentials?> get credentials async {
    if (_credentials != null) {
      return _credentials;
    }
    final stored = await storage.getItem(storageKey);
    print("Stored: $stored");
    if (stored == null) return null;
    try {
      _credentials = AuthCredentials.fromJson(stored);
    } catch (e) {
      print(e.toString());
    }
    return _credentials;
  }

  Future<void> setCredentials(AuthCredentials? credentials) async {
    print("setting credentials: ${credentials?.toJson()}");
    if (credentials == null) {
      clear();
      return;
    }

    await storage.setItem(storageKey, credentials.toJson());
    _credentials = credentials;
    print("seted credentials: ${_credentials?.toJson()}");
  }

  Future<String?> get access async => (await credentials)?.accessToken;

  Future<String?> get refresh async => (await credentials)?.refreshToken;

  Future<dynamic> login({required AuthFields fields}) async {
    final result = await apiService.actionAndGetResponseItems(
        url: loginUrl,
        authService: this,
        body: fields.toJson(),
        action: APIAction.post,
        headers: HiddenFormHeaders);

    debugPrint("login result: $result");
    if (result == null || result['access_token'] == null) return result;

    try {
      setCredentials(AuthCredentials.fromJson(result));

      MessageServiceFactory.SERVICE.startStream();
      NotificationServiceFactory.SERVICE.startStream();

      return result;
    } catch (e) {
      print("login error: $e");
      return null;
    }
  }

  Future<dynamic> register({required AuthFields fields}) async {
    final result = await apiService.actionAndGetResponseItems(
        authService: this,
        url: registerUrl,
        body: fields.toJson(),
        action: APIAction.post);

    return result;
  }
  Future<bool?> resetPassword({required AuthFields fields}) async {
    final result = await apiService.actionAndGetResponseItems(
        authService: this,
        url: passwordResetUrl + fields.email!,
        body: fields.toJson(),
        action: APIAction.post);

    return result != null;
  }

  void clear() async => storage.deleteItem(storageKey);
}
