import 'dart:io';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/models/results_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*this class for save sensitive data in secure storage local device. 
note :read All and delete All are not supported right now on windows*/
enum KeySecureStorage {
  token('token'),
  user('user');

  const KeySecureStorage(this.keySecure);
  final String keySecure;
}

class SecureStorage {
  final log = LoggerController();
  final _storage = const FlutterSecureStorage();
  final _androidOptions =
      const AndroidOptions(encryptedSharedPreferences: true);
  final _iosOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  Future<ResultController> isProtectedDataAvailable() async {
    try {
      final result = await _storage.isCupertinoProtectedDataAvailable();
      return ResultController(data: result, status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(
          LogLevel.error, 'Error checking protected data availability: $e');
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> writeNewItem(String key, String val) async {
    try {
      await _storage.write(
        key: key,
        value: val,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      return ResultController(
          data: 'new data has been wrote', status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(LogLevel.error,
          'Unhandled error in addNewItem method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> readOne(String key) async {
    try {
      String? val = await _storage.read(
          key: key, iOptions: _iosOptions, aOptions: _androidOptions);
      return ResultController(data: val, status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(LogLevel.error,
          'Unhandled error in readOneItem method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> readAll() async {
    if (Platform.isWindows) {
      return ResultController(
          error: 'Platform is Windows not supported',
          status: ResultsLevel.notSupported);
    }
    try {
      final all = await _storage.readAll(
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      return ResultController(data: all, status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(LogLevel.error,
          'Unhandled error in readAll method in SecureStorage :: $e');

      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> deleteOne(String key) async {
    try {
      await _storage.delete(
          key: key, iOptions: _iosOptions, aOptions: _androidOptions);

      // to do show snakbar that del is okay
      return ResultController(
          data: 'item has been delete', status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(LogLevel.error,
          'Unhandled error in deleteOne method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> deleteAll() async {
    if (Platform.isWindows) {
      return ResultController(
          error: 'Platform is Windows not supported to delete all item',
          status: ResultsLevel.notSupported);
    }
    try {
      await _storage.deleteAll(
          iOptions: _iosOptions, aOptions: _androidOptions);
      // to do show snakbar that del is okay
      return ResultController(
          data: 'data has been delete', status: ResultsLevel.success);
    } catch (e) {
      log.showLogger(LogLevel.error,
          'Unhandled error in deleteAll method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }
}
