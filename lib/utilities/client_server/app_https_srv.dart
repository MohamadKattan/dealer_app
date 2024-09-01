import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:dio/dio.dart';

class AppHttpsSrv {
  Map<String, String> normalHeader = {'Content-Type': 'application/json'};
  Map<String, String> authHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'token'
  };
  final dio = Dio(BaseOptions(
      sendTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
      baseUrl: 'http://localhost:3000/api/',
      validateStatus: (status) => status! < 500));

  Future<ResultController> getData(String root) async {
    try {
      dio.interceptors.add(LogInterceptor(responseBody: true));
      final response = await dio.get(root);
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

  Future<ResultController> postData(String url, Object data) async {
    try {
      // dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers = normalHeader;
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

  Future<ResultController> putData(String url, Object data) async {
    try {
      dio.interceptors.add(LogInterceptor(responseBody: true));
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

  Future<ResultController> deleteData(String url, Object data) async {
    try {
      dio.interceptors.add(LogInterceptor(responseBody: true));
      Response response = await dio.delete(url, data: data);
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
}
