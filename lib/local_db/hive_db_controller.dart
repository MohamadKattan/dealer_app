// this class ineclode hive locale db
import 'package:dealer/utilities/dev_helper/app_injector.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/dyanmic_data_res/results_controller.dart';
import 'package:hive/hive.dart';

enum BoxesLevel {
  boxSettings('settings');

  const BoxesLevel(this.boxName);
  final String boxName;
}

enum HiveKeyslevel {
  brightness('brightness');

  const HiveKeyslevel(this.keyName);
  final String keyName;
}

class LocalStorage {
  final String hiveDbName = 'dealerBox';
  final Set<String> nameBoxes = {BoxesLevel.boxSettings.boxName};
  BoxCollection? _boxCollectionCache;

  // create locale db
  Future<ResultController<BoxCollection>> _openDatabaseCollection() async {
    if (_boxCollectionCache != null) {
      return ResultController(
          data: _boxCollectionCache, status: ResultsLevel.success);
    }
    try {
      final box = await BoxCollection.open(hiveDbName, nameBoxes);
      _boxCollectionCache = box;
      return ResultController(data: box, status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger
          .showLogger(LogLevel.error, 'Failed to open database: $e');
      return ResultController(
          error: 'Failed to open database', status: ResultsLevel.fail);
    }
  }

  Future<ResultController<CollectionBox>> _startOpenBox(String boxName) async {
    try {
      final collection = await _openDatabaseCollection();
      if (collection.status == ResultsLevel.fail) {
        AppInjector.newLogger
            .showLogger(LogLevel.error, 'Failed to open local database.');
        return ResultController(
            error: 'Failed to open local database.', status: ResultsLevel.fail);
      }
      if (collection.data == null) {
        AppInjector.newLogger
            .showLogger(LogLevel.error, 'Retrieved data is null.');
        return ResultController(
            error: 'Retrieved data is null.', status: ResultsLevel.fail);
      }
      if (!nameBoxes.contains(boxName)) {
        AppInjector.newLogger
            .showLogger(LogLevel.error, 'Invalid box name: $boxName');
        return ResultController(
            error: 'Invalid box name', status: ResultsLevel.fail);
      }
      final newOpenBox = collection.data!;
      final resBox = await newOpenBox.openBox(boxName);
      return ResultController(data: resBox, status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to start open box', status: ResultsLevel.fail);
    }
  }

  // write new item
  Future<ResultController> putData(
      String boxName, String key, dynamic value) async {
    try {
      final box = await _startOpenBox(boxName);
      await box.data!.put(key, value);
      return ResultController(
          data: 'success put data', status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

// get one
  Future<ResultController> getOneItem(String boxName, String key) async {
    try {
      final box = await _startOpenBox(boxName);
      final result = await box.data!.get(key);
      return ResultController(data: result, status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to get data from locale', status: ResultsLevel.fail);
    }
  }

  // get all
  Future<ResultController> getAllItems(
      String boxName, List<String> keys) async {
    try {
      final box = await _startOpenBox(boxName);
      final result = await box.data!.getAll(keys);
      return ResultController(data: result, status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to get all  data from locale',
          status: ResultsLevel.fail);
    }
  }

// del one
  Future<ResultController> deleteOneItem(String boxName, String key) async {
    try {
      final box = await _startOpenBox(boxName);
      await box.data!.delete(key);
      return ResultController(
          data: 'item has been delted', status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to delete one  item from locale box $boxName',
          status: ResultsLevel.fail);
    }
  }

// del all
  Future<ResultController> deleteAllItems(
      String boxName, List<String> keys) async {
    try {
      final box = await _startOpenBox(boxName);
      await box.data!.deleteAll(keys);
      return ResultController(
          data: 'items has been delted', status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to  all delete items from locale box $boxName',
          status: ResultsLevel.fail);
    }
  }

//clear box
  Future<ResultController> clearBox(String boxName) async {
    try {
      final box = await _startOpenBox(boxName);
      box.data!.clear();
      return ResultController(
          data: 'cleared box $boxName', status: ResultsLevel.success);
    } catch (e) {
      AppInjector.newLogger.showLogger(LogLevel.error, e.toString());
      return ResultController(
          error: 'error to clear from locale box $boxName',
          status: ResultsLevel.fail);
    }
  }

// if needed use
  Future<void> clearCache() async {
    if (_boxCollectionCache != null) {
      _boxCollectionCache!.close();
      _boxCollectionCache = null;
    }
  }
}
