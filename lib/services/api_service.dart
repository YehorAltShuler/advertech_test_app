import 'package:advertech_test_task/services/api_service_interface.dart';
import 'package:dio/dio.dart';

class ApiService implements ApiServiceInterface {
  final int _requestTimeout = 5000;
  static final ApiService _instance = ApiService._internal();

  ApiService._internal();

  factory ApiService() => _instance;

  @override
  Future<Response> sendDataToServer({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: Duration(milliseconds: _requestTimeout),
          receiveTimeout: Duration(milliseconds: _requestTimeout),
        ),
      );

      final response = await dio.post(
        'https://api.byteplex.info/api/test/contact/',
        data: {
          'name': name,
          'email': email,
          'message': message,
        },
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Ошибка: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Таймаут запроса: $_requestTimeout мс');
      } else {
        throw Exception('Произошла ошибка при отправке запроса: $e');
      }
    } catch (error) {
      throw Exception('Произошла ошибка при отправке запроса: $error');
    }
  }
}
