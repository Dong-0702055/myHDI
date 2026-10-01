import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AuthApi {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8080",
    ),
  );
  AuthApi() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getAccessToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> login({
    required String phoneNumber,
    required String password,
  }) async {

    final response = await dio.post(
      "/api/auth/login",
      data: {
        "phoneNumber": phoneNumber,
        "password": password,
      },
    );

    return response.data;
  }
  Future<Map<String, dynamic>> register({
    required String firebaseToken,
    required String fullName,
    required String phoneNumber,
    required String password,
  }) async {

    final response = await dio.post(
      "/api/auth/register",
      data: {
        "firebaseToken": firebaseToken,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "password": password,
      },
    );

    return response.data;
  }

  Future<String> logout({required String refreshToken,}) async {
    final response = await dio.post(
      "/api/auth/logout",
      data: {
        "refreshToken": refreshToken,
      },
    );

    return response.data.toString();
  }

  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    final response = await dio.post(
      "/api/auth/refresh",
      data: {
        "refreshToken": refreshToken,
      },
    );

    return response.data;
  }
}
