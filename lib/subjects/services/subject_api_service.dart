import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/subjects/subjects.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class SubjectAPIService extends HideAndReportableAPIModelService<Subject> implements SubjectService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;


  @override
  ModelFactory<Subject> get modelFactory => SubjectFactory();

  @override
  String get modelType => "subject";


  @override
  String get url => URLManager.subjects;
}
