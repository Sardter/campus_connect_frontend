import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/borrowables/borrowables.dart';
import 'package:campus_connect_frontend/config/url_manager.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class BorrowableAPIService extends PostAPIService<Borrowable> implements BorrowableService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<Borrowable> get modelFactory => BorrowableFactory();

  @override
  String get modelType => "Post";

  @override
  String get url => URLManager.posts;
}