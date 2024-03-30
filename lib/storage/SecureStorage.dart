// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDatabase {
  final storage = const FlutterSecureStorage();
  void write(String key, String value) {
    storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return storage.read(key: key);
  }
}
