import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "http://192.168.56.1/terminal_bimodal/public/api";
  dio.options.headers['accept'] = 'Application/Json';
  return dio;
}
