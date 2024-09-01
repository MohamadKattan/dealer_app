// Define Bloc
import 'package:bloc/bloc.dart';
import 'package:dealer/local_db/secure_db_controller.dart';
import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(Inite()) {
    on<GetDataUserAndConfigEvent>(_getDataUserAndConfig);
  }
  final logger = LoggerController();

  _getDataUserAndConfig(
      GetDataUserAndConfigEvent event, Emitter<SplashState> emit) async {
    try {
      emit(Louding(txt: 'Loading user info'));
      await Future.delayed(const Duration(seconds: 2));
      final result = await AppInjector.localeSecureStorag
          .readOne(KeySecureStorage.user.keySecure);
      if (result.error != null) {
        logger.showLogger(LogLevel.error, result.error ?? 'error');
      }
      if (result.data != null) {
        logger.showLogger(
            LogLevel.info, 'user in local ${result.data} nav to home screen');
      }
      if (result.data == null) {
        logger.showLogger(
            LogLevel.info, 'No user in local push ==> to login screen');
        emit(GetDataAndConfigState(user: null));
      }
      emit(GetDataAndConfigState(newTxet: 'done'));
    } catch (e) {
      logger.showLogger(LogLevel.error, e.toString());
      emit(ErrorGetDate('error _getDataUserAndConfig :: ${e.toString()}'));
    }
  }
}
