// Define Bloc
import 'package:bloc/bloc.dart';
import 'package:dealer/views/splash/bloc/splash_event.dart';
import 'package:dealer/views/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState('null', 0)) {
    on<ChangeVal>((event, emit) => emit(SplashState('Mohamad', 10)));
    on<GetUserInfo>((event, emit) => emit(state));
  }
}
