import 'package:campus_connect_frontend/users/users.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

abstract class UserService<T extends User> extends ModelService<T> {
  Future<bool?> deleteProfile();

  Future<User?> editProfile({required User user});

  Future<User?> getProfile();

  Future<bool?> blockUser({required ItemParameters itemParameters});
}