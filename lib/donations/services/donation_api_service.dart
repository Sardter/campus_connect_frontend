import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/donations/donations.dart';
import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class DonationAPIService extends PostAPIService<Donation> implements DonationService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<Donation> get modelFactory => DonationFactory();

  @override
  String get modelType => "Post";

  @override
  String get url => URLManager.posts;
}