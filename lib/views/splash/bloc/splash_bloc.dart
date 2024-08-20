// Define Bloc
import 'package:bloc/bloc.dart';
import 'package:dealer/local_db/secure_db_controller.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(Inite()) {
    on<GetDataUserAndConfigEvent>(_getDataUserAndConfig);
  }
  final logger = LoggerController();
  final localeSecureStorag = SecureStorage();
  
  _getDataUserAndConfig(
      GetDataUserAndConfigEvent event, Emitter<SplashState> emit) async {
    try {
      emit(Louding(txt: 'Loading user info'));
      await Future.delayed(const Duration(seconds: 2));
      final result = await localeSecureStorag.readOne('user');
      if (result.error != null) {
        logger.showLogger('e', result.error ?? 'error');
      }
      if (result.data != null) {
        logger.showLogger(
            'i', 'user in local ${result.data} nav to home screen');
      }
      if (result.data == null) {
        logger.showLogger('i', 'No user in local push to login screen');
      }
      emit(GetDataAndConfigState(newTxet: 'done'));
    } catch (e) {
      logger.showLogger('e', e.toString());
      emit(ErrorGetDate('error _getDataUserAndConfig :: ${e.toString()}'));
    }
  }
}
