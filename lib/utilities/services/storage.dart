import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class StorageService {
  static final StorageService _storageService = StorageService._internal();
  factory StorageService() {
    return _storageService;
  }
  StorageService._internal();

  final _storage = LocalStorage('SocialUtil');

  Future<void> init() async {
    await _storage.ready;
  }

  Future<Map<String, dynamic>?> getItem(String key) async {
    try {
      return await _storage.getItem(key);
    } catch (e) {
      print("storage error: $e");
      return null;
    }
  }

  Future<bool> setItem(String key,Map<String, dynamic> value) async {
    try {
      await _storage.setItem(key, value);
      return true;
    } catch (e) {
      print("storage error: $e");
      return false;
    }
  }

  Future<bool> deleteItem(String key) async {
    try {
      await _storage.deleteItem(key);
      return true;
    } catch (e) {
      print("storage error: $e");
      return false;
    }
  }
}