import 'package:dio/dio.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://appabsensi.mobileprojp.com",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ), // BaseOptions
  ); // Dio

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
