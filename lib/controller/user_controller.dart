import 'dart:convert';

import 'package:dealer/local_db/secure_db_controller.dart';
import 'package:dealer/models/user_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/models/results_controller.dart';

class UserController {
  UserModel _user = UserModel();
  UserModel get user => _user;

  Future<ResultController> getUserFromLocal() async {
    try {
      final result = await AppGetter.localeSecureStorag
          .readOne(KeySecureStorage.user.keySecure);

      if (result.error != null) {
        return ResultController(error: result.error, status: ResultsLevel.fail);
      } else if (result.data != null) {
        final map = jsonDecode(result.data) as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(map);
        await _userProvider(user);
        return ResultController(data: true, status: ResultsLevel.success);
      } else {
        return ResultController(data: false, status: ResultsLevel.success);
      }
    } catch (e) {
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<ResultController> setUserToLocal(Map<String, dynamic> map) async {
    try {
      final user = UserModel.fromMap(map['data']);
      String convertUser = jsonEncode({
        'user_name': user.userName,
        'per': user.per,
        'user_id': user.userId,
        'address': user.address,
        'token': user.token
      });
      final resultSet = await AppGetter.localeSecureStorag
          .writeNewItem(KeySecureStorage.user.keySecure, convertUser);
      if (resultSet.error != null) {
        return ResultController(
            error: resultSet.error, status: ResultsLevel.fail);
      } else {
        final resultGet = await getUserFromLocal();
        if (resultGet.error != null) {
          return ResultController(
              error: resultSet.error, status: ResultsLevel.fail);
        } else {
          return ResultController(data: true, status: ResultsLevel.success);
        }
      }
    } catch (e) {
      return ResultController(error: e.toString(), status: ResultsLevel.fail);
    }
  }

  Future<void> _userProvider(UserModel user) async {
    _user = user;
    AppGetter.per = _user.per ?? 'null per';
    AppGetter.usertoken = _user.token ?? 'null token';
    AppGetter.userName = _user.userName ?? 'null UserName';
  }
}
