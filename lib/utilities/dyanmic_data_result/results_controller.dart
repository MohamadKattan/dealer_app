import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dio/dio.dart';

enum ResultsLevel { success, fail, notSupported }

class ResultController<T> {
  final T? data;
  final String? error;
  final ResultsLevel? status;
  ResultController({this.data, this.error, this.status});

// return new data if => 200
  static ResultController newData(res) {
    final newData = res;
    return ResultController(data: newData, status: ResultsLevel.success);
  }

  // return eror if => !200
  static ResultController errorHandle(Object e) {
    if (e is DioException) {
      AppInjector.appLogger
          .showLogger(LogLevel.error, 'dio error ${e.message}');
      return ResultController(
          error: 'error : ${e.message}', status: ResultsLevel.fail);
    } else {
      AppInjector.appLogger
          .showLogger(LogLevel.error, 'UnHandel error ${e.toString()}');
      return ResultController(error: ' error : $e', status: ResultsLevel.fail);
    }
  }
}
