import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class KeyStoreService {
  Future<String> get(String key);

  Future<void> delete(String key);

  Future<void> set(String key, String value);

  Future<void> setJson(String key, Map<String, String> value);

  Future<Map<String, String>> getJson(String key);
}

class KeyStoreServiceImpl implements KeyStoreService {
  final _storage = FlutterSecureStorage();

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<String> get(String key) => _storage.read(key: key);

  @override
  Future<void> set(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<Map<String, String>> getJson(String key) async {
    final json = await _storage.read(key: key);
    return jsonDecode(json);
  }

  @override
  Future<void> setJson(String key, Map<String, String> value) async {
    final json = jsonEncode(value);
    await _storage.write(key: key, value: json);
  }
}
