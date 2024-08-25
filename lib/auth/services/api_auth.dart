import 'package:campus_connect_frontend/auth/auth.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class APIAuthService extends AuthService {
  @override
  APIService get apiService => APIServiceFactory.SERVICE;

  @override
  String get loginUrl => "https://api.campusconnect.yuiozasx.com/auth/login/";

  @override
  String get passwordResetUrl => "https://api.campusconnect.yuiozasx.com/auth/reset-password/";

  @override
  String get registerUrl => "https://api.campusconnect.yuiozasx.com/auth/register/";

  @override
  StorageService get storage => StorageServiceFactory.SERVICE;

  @override
  String get storageKey => "auth"; 
}