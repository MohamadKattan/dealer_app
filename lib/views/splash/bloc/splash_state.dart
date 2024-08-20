// Define states of splash screen
import 'package:dealer/models/user_model.dart';

abstract class SplashState {}

class Inite extends SplashState {}

class Louding extends SplashState {
  final String? txt;
  Louding({this.txt});
}

// state read user data & config if from local or remont.
class GetDataAndConfigState extends SplashState {
  final String? newTxet;
  final User? user;

  GetDataAndConfigState({this.newTxet, this.user});
}

class ErrorGetDate extends SplashState {
  String? errorMsg;
  ErrorGetDate(this.errorMsg);
}
