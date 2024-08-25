import 'package:campus_connect_frontend/utilities/utilities.dart';

class StorageServiceFactory {
  static final StorageServiceFactory _factory = StorageServiceFactory._internal();
  factory StorageServiceFactory() {
    return _factory;
  }
  StorageServiceFactory._internal();

  // ignore: non_constant_identifier_names
  static final SERVICE = StorageService();
}