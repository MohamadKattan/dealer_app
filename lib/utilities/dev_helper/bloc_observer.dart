// this class to debuge states change  and transition in bloc

import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {
      AppInjector.appLogger.showLogger(LogLevel.info, change.toString());
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    AppInjector.appLogger.showLogger(LogLevel.info, transition.toString());
  }
}
