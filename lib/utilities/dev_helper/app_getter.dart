// this class for decler and inject static valus ones

import 'package:dealer/controller/user_controller.dart';
import 'package:dealer/local_db/hive_db_controller.dart';
import 'package:dealer/local_db/secure_db_controller.dart';
import 'package:dealer/utilities/client_server/app_https_srv.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:flutter/material.dart';

class AppGetter {
  static final _localStorage = LocalStorage();
  static LocalStorage get localStorage => _localStorage;

  static final _localeSecureStorag = SecureStorage();
  static SecureStorage get localeSecureStorag => _localeSecureStorag;

  static final _httpSrv = AppHttpsSrv();
  static AppHttpsSrv get httpSrv => _httpSrv;

  static final LoggerController _logger = LoggerController();
  static LoggerController get appLogger => _logger;

  static final UserController _userController = UserController();
  static UserController get userController => _userController;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

// user
  static String? usertoken;
  static String? per;
  static String? userName;
// env
  static String? checkPer;
// val in drawer
  static bool isMorning = false;
  static String? dateOFToday;
}
