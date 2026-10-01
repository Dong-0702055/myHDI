import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {

  static const _storage = FlutterSecureStorage();

  static Future<void> saveAccessToken(
      String token,
      ) async {

    await _storage.write(
      key: "access_token",
      value: token,
    );
  }

  static Future<void> saveRefreshToken(
      String token,
      ) async {

    await _storage.write(
      key: "refresh_token",
      value: token,
    );
  }

  static Future<String?> getAccessToken() async {
    return _storage.read(
      key: "access_token",
    );
  }

  static Future<void> logout() async {
    await _storage.deleteAll();
  }

  static Future<String?> getRefreshToken() async {
    return _storage.read(
      key: "refresh_token",
    );
  }

}