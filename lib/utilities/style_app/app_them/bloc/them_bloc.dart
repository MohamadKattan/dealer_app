import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/style_app/app_them/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// this class controle theme system state

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc() : super(AppTheme.lightTheme);

  void toggleTheme() {
    emit(state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme);
    AppInjector.newLogger.showLogger(LogLevel.info, state.brightness.toString());
  }
}
