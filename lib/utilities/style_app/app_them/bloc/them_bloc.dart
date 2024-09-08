import 'package:dealer/local_db/hive_db_controller.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:dealer/utilities/style_app/app_them/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// this class controle theme system state

enum ThemeLevel {
  dark('dark'),
  light('light');

  const ThemeLevel(this.nameTheme);
  final String nameTheme;
}

class ThemeBloc extends Cubit<ThemeData> {
  ThemeBloc() : super(AppTheme.lightTheme);

  void getTheme() async {
    try {
      final res = await AppGetter.localStorage.getOneItem(
          BoxesLevel.boxSettings.boxName, HiveKeyslevel.brightness.keyName);
      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger.showLogger(LogLevel.error, res.error ?? 'error');
        return;
      }

      if (res.data == null || res.data.runtimeType != String) {
        AppGetter.appLogger.showLogger(LogLevel.warning, 'Defult them');
        return;
      }
      String result = res.data;
      if (result == ThemeLevel.dark.nameTheme) {
        emit(AppTheme.darkTheme);
      } else {
        emit(AppTheme.lightTheme);
      }
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());

      return;
    }
  }

   toggleTheme() async {
    emit(state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme);
    await AppGetter.localStorage.putData(BoxesLevel.boxSettings.boxName,
        HiveKeyslevel.brightness.keyName, state.brightness.name);
    AppGetter.appLogger.showLogger(LogLevel.info, state.brightness.name);
  }
}
