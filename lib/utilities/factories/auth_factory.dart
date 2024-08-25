import 'package:campus_connect_frontend/auth/auth.dart';
class APIAuthServiceFactory {
  static final APIAuthServiceFactory _factory = APIAuthServiceFactory._internal();
  factory APIAuthServiceFactory() {
    return _factory;
  }
  APIAuthServiceFactory._internal();

  // ignore: non_constant_identifier_names
  static final SERVICE = APIAuthService();
}