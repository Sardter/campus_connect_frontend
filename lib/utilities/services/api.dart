// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campus_connect_frontend/auth/auth.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:campus_connect_frontend/utilities/utilities.dart';

enum APIAction { get, post, delete, put }

// ignore: constant_identifier_names
const HiddenFormHeaders = {
  HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
};

class APIService {
  final String tokenRefreshUrl;

  static List<int> safeStatus = const [200, 201];

  APIService({required this.tokenRefreshUrl});

  Future<http.Response> _get({required String url, String? token}) async {
    return await http.get(Uri.parse(url), headers: {
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }

  String? _getLoginHiddenForm(Map? body) {
    if (body == null) return null;
    return "username=${body['username']}&password=${body['password']}&email=${body['email']}";
  }

  Future<http.Response> _post(
      {required String url,
      String? token,
      required Map? body,
      required Map<String, String>? headers}) async {
    return await http.post(Uri.parse(url),
        headers: headers ??
            {
              if (token != null)
                HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            },
        body: headers == HiddenFormHeaders
            ? _getLoginHiddenForm(body)
            : jsonEncode(body));
  }

  Future<http.Response> _put(
      {required String url, String? token, required Map? body}) async {
    return await http.put(Uri.parse(url),
        headers: {
          if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> _delete({required String url, String? token}) async {
    return await http.delete(Uri.parse(url), headers: {
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
  }

  static Future<dynamic> _decodeResponse(
      http.Response response, BuildContext? context,
      {bool showErrors = true}) async {
    try {
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      if (!safeStatus.contains(response.statusCode) &&
          showErrors &&
          context != null) {
        for (List errors in decoded.values) {
          for (var error in errors) {
            await showSocialUtilSnackbar(
                context: context,
                message: error,
                type: DisplayMessageType.danger);
          }
        }
      }
      return decoded;
    } catch (e) {
      if (showErrors && context != null)
        await showSocialUtilSnackbar(
            context: context,
            message: "Something went wrong!",
            type: DisplayMessageType.danger);
      return null;
    }
  }

  Future<bool> _refreshToken(BuildContext? context, AuthService auth) async {
    String? token = await auth.refresh;

    if (token == null) return false;

    final response = await _post(
      url: tokenRefreshUrl,
      body: {'token': token},
      headers: null,
    );
    final items = await _decodeResponse(response, context);
    if (response.statusCode == 401) return false;

    try {
      auth.setCredentials(AuthCredentials.fromJson(items));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<http.Response> _actionAndResponse(
      {required String url,
      required String? accessToken,
      required Map? body,
      required Map<String, String>? headers,
      required APIAction action}) async {
    switch (action) {
      case APIAction.get:
        return _get(url: url, token: accessToken);
      case APIAction.post:
        return _post(
            url: url, body: body, token: accessToken, headers: headers);
      case APIAction.delete:
        return _delete(url: url, token: accessToken);
      case APIAction.put:
        return _put(url: url, body: body, token: accessToken);
    }
  }

  Future<dynamic> actionAndGetResponseItems(
      {BuildContext? context,
      required String url,
      required AuthService authService,
      Map? body,
      Map<String, String>? headers,
      bool showDecodeErrors = true,
      APIAction action = APIAction.get}) async {
    final authCred = await authService.credentials;
    http.Response? response;

    print("auth cred: ${authCred?.toJson()}");

    if (authCred == null) {
      response = await _actionAndResponse(
          url: url,
          accessToken: null,
          body: body,
          action: action,
          headers: headers);
    } else {
      final access = (await authService.credentials)?.accessToken;
      print("access token: $access");
      response = await _actionAndResponse(
          url: url,
          accessToken: access,
          body: body,
          headers: headers,
          action: action);
      print("access token: ${response.statusCode}");
      if (!safeStatus.contains(response.statusCode)) {
        if (!await _refreshToken(context, authService)) {
          print("here 1");
          response = await _actionAndResponse(
              url: url,
              accessToken: null,
              body: body,
              action: action,
              headers: headers);
        } else {
          print("here 2");
          response = await _actionAndResponse(
              url: url,
              headers: headers,
              accessToken: (await authService.credentials)?.accessToken,
              body: body,
              action: action);
        }

        if (!safeStatus.contains(response.statusCode)) {
          print("here 3");
          if (context != null)
            await showSocialUtilSnackbar(
                context: context, message: "Logged out");
          authService.clear();
        }
      }
    }

    print("body: ${jsonEncode(body)}");

    print("url: $url");
    if (response.statusCode != 200)
      print("response (${response.statusCode}): ${response.body}");

    return await _decodeResponse(response, context,
        showErrors: showDecodeErrors);
  }
}
