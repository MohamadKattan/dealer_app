import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<int> {
  LoginBloc() : super(0);

  Future<ResultController> newLogin() async {
    // emit(1);
    // await Future.delayed(const Duration(seconds: 3));
    // emit(0);
    try {
      final result = await AppInjector.httpSrv
          .getData('https://localhost:3000/api/');
      if (result.status == ResultsLevel.fail) {
        return ResultController.errorHandle(result.error!);
      }
      return ResultController.newData(result.data!);
    } catch (e) {
      return ResultController.errorHandle(e);
    }
  }

  Future<void> signOut() async {}
}
