import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class UserTestService extends ModelService<User> implements UserService {
  @override
  Future<bool?> deleteItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<User?> getItem({required ItemParameters itemParameters}) async {
    return (await getList())?.first;
  }

  @override
  Future<List<User>?> getList({QueryParameters<Model>? queryParameters}) async {
    return const [
      User(
          id: 1,
          email: "sardter",
          bio: "Bio text",
          firstName: "Sadra",
          allowedActions: UserAllowedActions(
              canUpdate: true,
              canDelete: true,
              canHide: true,
              canBlock: true,
              canReport: true),
          lastName: "Mohammadzadehazarabadi"),
      User(id: 1, email: "sardter"),
      User(id: 1, email: "sardter"),
      User(id: 1, email: "sardter"),
      User(id: 1, email: "sardter"),
      User(id: 1, email: "sardter"),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters<Model>? queryParameters}) async {
    return (await getList())?.length;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    return true;
  }

  @override
  Future<User?> postItem({required User item}) async {
    return item;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return true;
  }

  @override
  Future<User?> updateItem(
      {required User updatedItem,
      required ItemParameters itemParameters}) async {
    return updatedItem;
  }

  @override
  Future<bool?> deleteProfile() async {
    return true;
  }

  @override
  Future<User?> editProfile({required User user}) async {
    return user;
  }

  @override
  Future<User?> getProfile() async {
    return (await getList())?.first;
  }

  @override
  Future<bool?> blockUser({required ItemParameters itemParameters}) async {
    return true;
  }
}
