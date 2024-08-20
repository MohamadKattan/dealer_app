import 'dart:io';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/results_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*this class for save sensitive data in secure storage local device. 
note :read All and delete All are not supported right now on windows*/
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
      return ResultController(data: result, status: 'ok');
    } catch (e) {
      log.showLogger('e', 'Error checking protected data availability: $e');
      return ResultController(error: e.toString(), status: 'fail');
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
      return ResultController(data: 'new data has been wrote', status: 'ok');
    } catch (e) {
      log.showLogger(
          'e', 'Unhandled error in addNewItem method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: 'fail');
    }
  }

  Future<ResultController> readOne(String key) async {
    try {
      String? val = await _storage.read(
          key: key, iOptions: _iosOptions, aOptions: _androidOptions);
      return ResultController(data: val, status: 'ok');
    } catch (e) {
      log.showLogger(
          'e', 'Unhandled error in readOneItem method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: 'fail');
    }
  }

  Future<ResultController> readAll() async {
    if (Platform.isWindows) {
      return ResultController(
          error: 'Platform is Windows not supported', status: 'not supported');
    }
    try {
      final all = await _storage.readAll(
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      return ResultController(data: all, status: 'ok');
    } catch (e) {
      log.showLogger(
          'e', 'Unhandled error in readAll method in SecureStorage :: $e');

      return ResultController(error: e.toString(), status: 'fail');
    }
  }

  Future<ResultController> deleteOne(String key) async {
    try {
      await _storage.delete(
          key: key, iOptions: _iosOptions, aOptions: _androidOptions);

      // to do show snakbar that del is okay
      return ResultController(data: 'item has been delete', status: 'ok');
    } catch (e) {
      log.showLogger(
          'e', 'Unhandled error in deleteOne method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: 'fail');
    }
  }

  Future<ResultController> deleteAll() async {
    if (Platform.isWindows) {
      return ResultController(
          error: 'Platform is Windows not supported to delete all item',
          status: 'not supported');
    }
    try {
      await _storage.deleteAll(
          iOptions: _iosOptions, aOptions: _androidOptions);
      // to do show snakbar that del is okay
      return ResultController(data: 'data has been delete', status: 'ok');
    } catch (e) {
      log.showLogger(
          'e', 'Unhandled error in deleteAll method in SecureStorage :: $e');
      return ResultController(error: e.toString(), status: 'fail');
    }
  }
}
