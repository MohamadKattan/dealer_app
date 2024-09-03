// Define Bloc

import 'package:bloc/bloc.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(Inite()) {
    on<GetDataUserAndConfigEvent>(_getDataUserAndConfig);
  }
  _getDataUserAndConfig(
      GetDataUserAndConfigEvent event, Emitter<SplashState> emit) async {
    try {
      emit(Louding(txt: 'Loading user info'));
      if (AppGetter.per != null) {
        emit(GetDataAndConfigState(isUser: true));
      } else {
        final result = await AppGetter.userController.getUserFromLocal();
        if (result.error != null) {
          emit(GetDataAndConfigState(isUser: false));
          AppGetter.appLogger
              .showLogger(LogLevel.error, result.error ?? 'error');
        }
        if (result.data == true) {
          emit(GetDataAndConfigState(isUser: true));
          AppGetter.appLogger.showLogger(
              LogLevel.info, 'user in local ${result.data} nav to home screen');
        }
        if (result.data == false) {
          AppGetter.appLogger.showLogger(
              LogLevel.info, 'No user in local push ==> to login screen');
          emit(GetDataAndConfigState(isUser: false));
        }
      }
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(ErrorGetDate('error _getDataUserAndConfig :: ${e.toString()}'));
    }
  }
}
