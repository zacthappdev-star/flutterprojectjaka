import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static String? token;
  // Sesuaikan dengan Base URL API yang digunakan
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://appabsensi.mobileprojp.com/api'))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              options.headers['Accept'] = 'application/json';
              return handler.next(options);
            },
          ),
        );

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = 'Terjadi kesalahan saat login: ${e.message}';
      if (data is Map) {
        if (data['message'] != null) {
          errorMessage = data['message'].toString();
        }
      } else if (data is String && data.isNotEmpty) {
        errorMessage = data;
      }
      throw errorMessage;
    }
  }

  // ---------- REGISTER ----------
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String jenisKelamin,
    required String batchId,
    required String trainingId,
    String? profilePhoto,
  }) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'jenis_kelamin': jenisKelamin,
          'batch_id': int.tryParse(batchId) ?? 0,
          'training_id': int.tryParse(trainingId) ?? 0,
          'profile_photo': profilePhoto ?? '',
        },
      );
      return response;
    } on DioException catch (e) {
      final data = e.response?.data;

      // Debug: lihat bentuk asli error dari server di Debug Console
      debugPrint('REGISTER ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('REGISTER ERROR DATA: $data');

      String errorMessage = 'Terjadi kesalahan saat register: ${e.message}';

      if (data is Map) {
        if (data['message'] != null) {
          errorMessage = data['message'].toString();
        } else if (data['errors'] != null && data['errors'] is Map) {
          // Laravel biasanya balas validasi error per-field begini:
          // "errors": { "training_id": ["The training id must be an integer."] }
          final errors = data['errors'] as Map;
          errorMessage = errors.values
              .expand((list) => (list as List).map((e) => e.toString()))
              .join('\n');
        }
      } else if (data is String && data.isNotEmpty) {
        errorMessage = data;
      }

      throw errorMessage;
    }
  }

  // ---------- PROFILE ----------
  Future<Response> getProfile() async {
    try {
      return await _dio.get('/profile');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> updateProfile({required String name}) async {
    try {
      return await _dio.put('/profile', data: {'name': name});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> updateProfilePhoto({required String base64Image}) async {
    try {
      return await _dio.put(
        '/profile/photo',
        data: {'profile_photo': base64Image},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ---------- TRAININGS ----------
  Future<Response> getTrainings() async {
    try {
      return await _dio.get('/trainings');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> getTrainingById(int id) async {
    try {
      return await _dio.get('/trainings/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ---------- BATCHES ----------
  Future<Response> getBatches() async {
    try {
      return await _dio.get('/batches');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ---------- USERS ----------
  Future<Response> getAllUsers() async {
    try {
      return await _dio.get('/users');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return 'Terjadi kesalahan: ${e.message}';
  }
}
