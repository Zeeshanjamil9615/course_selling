import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  setLogin(data) async {
    await storage.write(key: 'user', value: jsonEncode(data));
    return true;
  }

  getLogin() async {
    dynamic value = await storage.read(key: 'user');
    if (value != null) {
      return jsonDecode(value);
    } else {
      return false;
    }
  }

  // Create
  Future<void> SetData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  // Read
  Future<String?> GetSecureData(String key) async {
    String? value = await storage.read(key: key);
    return value ?? '';
  }

  // Update
  Future<void> updateSecureData(String key, String newValue) async {
    await storage.write(key: key, value: newValue);
  }

  // Delete
  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  // Delete all data
  Future<void> deleteAllSecureData() async {
    await storage.deleteAll();
  }
}
