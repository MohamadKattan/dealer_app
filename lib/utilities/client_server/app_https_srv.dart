import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:dio/dio.dart';

class AppHttpsSrv {
  final dio = Dio();

  Future<ResultController> getData(String url) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController.errorHandle(response.data);
      }
      return ResultController.newData(response.data);
    } catch (e) {
      return ResultController.errorHandle(e);
    }
  }

  Future<ResultController> postData(String url, Object data) async {
    try {
      print('hhhhhh');
      final response = await dio.post(
        url,
        data: data,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
      print(response);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController.errorHandle(response.data);
      }
      return ResultController.newData(response.data);
    } catch (e) {
      return ResultController.errorHandle(e);
    }
  }

  Future<ResultController> updateData(String url, Object data) async {
    try {
      Response response = await dio.put(url, data: data);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController.errorHandle(response.data);
      }
      return ResultController.newData(response.data);
    } catch (e) {
      return ResultController.errorHandle(e);
    }
  }

  Future<ResultController> deleteData(String url, Object data) async {
    try {
      Response response = await dio.delete(url, data: data);
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return ResultController.errorHandle(response.data);
      }
      return ResultController.newData(response.data);
    } catch (e) {
      return ResultController.errorHandle(e);
    }
  }
}
