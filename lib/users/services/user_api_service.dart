import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/config/URL_Manager.dart';
import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class UserAPIService extends HideAndReportableAPIModelService<User>
    implements UserService {
  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  Future<Map<String, dynamic>?> _deleteAPIItem() async {
    return await api.actionAndGetResponseItems(
        authService: authService, url: meUrl, action: APIAction.delete);
  }

  Future<Map<String, dynamic>?> _blockUser(
      {required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: "$url${itemParameters}block",
        authService: authService,
        action: APIAction.post);
  }

  Future<Map<String, dynamic>?> _updateAPIItem(
      {required Map<String, dynamic> updatedItem}) async {
    return await api.actionAndGetResponseItems(
        authService: authService,
        context: null,
        url: meUrl,
        action: APIAction.put,
        body: updatedItem);
  }

  @override
  Future<bool?> deleteProfile() async {
    return (await _deleteAPIItem())?['status'];
  }

  @override
  Future<User?> editProfile({required User user}) async {
    final data = await _updateAPIItem(updatedItem: user.toJson());
    if (data?['updated'] == null) return null;

    onModelWithMedia(data!, user);

    return modelFactory.fromJson(data['updated']);
  }

  @override
  Future<User?> updateItem(
      {required User updatedItem,
      required ItemParameters itemParameters}) async {
    return editProfile(user: updatedItem);
  }

  Future<Map<String, dynamic>?> _getProfile() async {
    return await api.actionAndGetResponseItems(
        url: "${url}me/", authService: authService);
  }

  @override
  Future<User?> getProfile() async {
    if (!await APIAuthServiceFactory.SERVICE.isLogedIn) return null;
    final item = await _getProfile();

    if (item == null) return null;

    return modelFactory.fromJson(item);
  }

  @override
  ModelFactory<User> get modelFactory => UserFactory();

  @override
  String get modelType => "User";

  @override
  String get url => URLManager.users;

  String get meUrl => URLManager.me;

  @override
  Future<bool?> blockUser({required ItemParameters itemParameters}) async {
    return (await _blockUser(itemParameters: itemParameters))?['status'];
  }
}
