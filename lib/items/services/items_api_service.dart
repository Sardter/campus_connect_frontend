import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/items/items.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class ItemAPIService extends HideAndReportableAPIModelService<Item> implements ItemService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;


  @override
  ModelFactory<Item> get modelFactory => ItemFactory();

  @override
  String get modelType => "item";


  @override
  String get url => URLManager.items;
}
