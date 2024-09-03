// Define states of splash screen

abstract class SplashState {}

class Inite extends SplashState {}

class Louding extends SplashState {
  final String? txt;
  Louding({this.txt});
}

// state read user data & config if from local or remont.
class GetDataAndConfigState extends SplashState {
  final bool isUser;

  GetDataAndConfigState({required this.isUser});
}

class ErrorGetDate extends SplashState {
  String? errorMsg;
  ErrorGetDate(this.errorMsg);
}
