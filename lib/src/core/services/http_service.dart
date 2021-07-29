import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  static Dio dio = Dio(BaseOptions(baseUrl: dotenv.env["LYRICS_HOST"]!))
    ..interceptors.addAll([
      LogInterceptor(request: false, requestHeader: false, responseHeader: false),
    ]);
}
