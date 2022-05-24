import 'package:dio/dio.dart';

import '../../flavors.dart';
import '../../infrastructure/apis/api_interceptor.dart';

class DioService {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: F.variables['baseURL'] as String,
        // connectTimeout: 60 * 1000, // 60 seconds
      ),
    );

    dio.interceptors.add(ApiInterceptor());

    return dio;
  }
}
