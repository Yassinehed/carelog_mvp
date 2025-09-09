import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal wrapper around flutter_secure_storage.
/// On web, flutter_secure_storage is not available; use an in-memory fallback.
class SecureStorage {
  final FlutterSecureStorage? _storage = kIsWeb ? null : const FlutterSecureStorage();
  final Map<String, String> _inMemory = {};

  Future<void> write(String key, String value) async {
    if (_storage != null) {
      await _storage.write(key: key, value: value);
    } else {
      _inMemory[key] = value;
    }
  }

  Future<String?> read(String key) async {
    if (_storage != null) {
      return await _storage.read(key: key);
    }
    return _inMemory[key];
  }

  Future<void> delete(String key) async {
    if (_storage != null) {
      await _storage.delete(key: key);
    } else {
      _inMemory.remove(key);
    }
  }
}
