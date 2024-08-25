import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/lost_and_founds/lost_and_founds.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class LostAndFoundAPIService extends PostAPIService<LostAndFound>
    implements LostAndFoundService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<LostAndFound> get modelFactory => LoastAndFoundFactory();

  @override
  String get modelType => "Post";

  @override
  String get url => URLManager.posts;
}
