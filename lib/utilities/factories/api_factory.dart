import 'package:campus_connect_frontend/utilities/utilities.dart';

class APIServiceFactory {
  static final APIServiceFactory _factory = APIServiceFactory._internal();
  factory APIServiceFactory() {
    return _factory;
  }
  APIServiceFactory._internal();

  // ignore: non_constant_identifier_names
  static final SERVICE = APIService(tokenRefreshUrl: "https://api.campusconnect.yuiozasx.com/auth/refresh_token");
}