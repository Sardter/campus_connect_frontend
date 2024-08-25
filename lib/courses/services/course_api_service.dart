import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/courses/courses.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CourseAPIService extends HideAndReportableAPIModelService<Course> implements CourseService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;


  @override
  ModelFactory<Course> get modelFactory => CourseFactory();

  @override
  String get modelType => "course";


  @override
  String get url => URLManager.courses;
}
