import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/second_hands/second_hands.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SecondHandAPIService extends PostAPIService<SecondHand> implements SecondHandService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<SecondHand> get modelFactory => SecondHandFactory();

  @override
  String get modelType => "Post";

  @override
  String get url => URLManager.posts;
}