import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/models/results_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppHttpsSrv {
  String baseUrl = dotenv.get('API_URL', fallback: 'sane-default');
  Map<String, String> normalHeader = {'Content-Type': 'application/json'};
  final dio = Dio(BaseOptions(
      sendTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      validateStatus: (status) => status! < 500));

  Future<ResultController> getData(String root, {bool isAuth = false}) async {
    try {
      // dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.baseUrl = baseUrl;
      if (isAuth) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': AppGetter.usertoken ?? ''
        };
      }
      final response = await dio.get(root);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController(
            data: response.data, status: ResultsLevel.fail, error: 'error');
      }
      return ResultController(
          data: response.data, status: ResultsLevel.success);
    } catch (e) {
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> postData(String url, Object data,
      {bool isAuth = false}) async {
    try {
      // dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.baseUrl = baseUrl;
      if (isAuth) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': AppGetter.usertoken ?? ''
        };
      }
      final response = await dio.post(url, data: data);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController(
            data: response.data, status: ResultsLevel.fail, error: 'error');
      }
      return ResultController(
          data: response.data, status: ResultsLevel.success);
    } catch (e) {
      return ResultController(
          data: e.toString(), status: ResultsLevel.fail, error: 'error');
    }
  }

  Future<ResultController> putData(String url, Object data,
      {bool isAuth = false}) async {
    try {
      dio.options.baseUrl = baseUrl;
      if (isAuth) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': AppGetter.usertoken ?? ''
        };
      }
      Response response = await dio.put(url, data: data);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController(data: response.data, status: ResultsLevel.fail);
      }
      return ResultController(
          data: response.data, status: ResultsLevel.success);
    } catch (e) {
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> deleteData(String url, Object data,
      {bool isAuth = false}) async {
    try {
      dio.options.baseUrl = baseUrl;
      if (isAuth) {
        dio.options.headers = {
          'Content-Type': 'application/json',
          'Authorization': AppGetter.usertoken ?? ''
        };
      }
      Response response = await dio.delete(url, data: data);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController(
            data: response.data, status: ResultsLevel.fail, error: 'error');
      }
      return ResultController(
          data: response.data, status: ResultsLevel.success);
    } catch (e) {
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }
}
