import 'package:dio/dio.dart';

abstract class ApiServiceInterface {
  Future<Response> sendDataToServer({
    required String name,
    required String email,
    required String message,
  });
}
