import 'dart:async';
import 'dart:convert';

import 'package:dealer/models/db_remote_model.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/utilities/dyanmic_data_result/results_controller.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_event.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DbRemoteSubUrl {
  createNewTable('createTable'),
  getAllTables('showTables');

  const DbRemoteSubUrl(this.subRoute);
  final String subRoute;
}

class DbRemoteBloc extends Bloc<DbRemoteEvent, DbRemoteState> {
  DbRemoteBloc() : super(Inite()) {
    on<ClickCreateTableEvent>(_clickCreateNewTablebTN);
    on<CancleCreateTableEvent>(_cancleCreateTableBtn);
    on<AddNewColumnEvent>(_addNewColumn);
    on<RemoveOneColumnEvent>(_removeOneColumn);
    on<RefreshAllTablesEvent>(_refreshTablseBtn);
    on<SaveTableOnRemoteDbEvent>(_saveTableOnRemoteDb);
    on<GetAllTablesEvent>(_getAllTablesFromDb);
  }

  _clickCreateNewTablebTN(
      ClickCreateTableEvent event, Emitter<DbRemoteState> emit) {
    emit(ClickCreateTableState(isClicked: true));
  }

  _cancleCreateTableBtn(
      CancleCreateTableEvent event, Emitter<DbRemoteState> emit) {
    emit(CancleCreateTableState(isClicked: false));
  }

  _refreshTablseBtn(RefreshAllTablesEvent event, Emitter<DbRemoteState> emit) {}

  _addNewColumn(AddNewColumnEvent event, Emitter<DbRemoteState> emit) async {
    emit(AddNewColumnState());
    await Future.delayed(const Duration(seconds: 4));
    emit(Inite());
  }

  _removeOneColumn(RemoveOneColumnEvent event, Emitter<DbRemoteState> emit) {
    emit(RemoveOneColumnState());
  }

  _saveTableOnRemoteDb(
      SaveTableOnRemoteDbEvent event, Emitter<DbRemoteState> emit) async {
    String? tableName = event.tableName;
    if (tableName.isEmpty) {
      emit(SaveTableOnRemoteDbState(error: 'Table Name is empty'));
      return;
    }

    try {
      emit(LoudingState());
      final tableModel =
          DbRemoteModel(tableName: tableName, listOfColumns: event.listColumn);
      final body = tableModel.toJson();
      final res = await AppGetter.httpSrv
          .postData(DbRemoteSubUrl.createNewTable.subRoute, body, isAuth: true);
      final deCodeData = jsonDecode(res.data);
      if (res.status == ResultsLevel.fail) {
        AppGetter.appLogger
            .showLogger(LogLevel.error, deCodeData['msg'] ?? 'error');
        emit(SaveTableOnRemoteDbState(error: deCodeData['msg'] ?? 'error'));
        return;
      }
      emit(SaveTableOnRemoteDbState(msg: deCodeData['msg']));
    } catch (e) {
      emit(SaveTableOnRemoteDbState(error: e.toString()));
      AppGetter.appLogger
          .showLogger(LogLevel.error, 'An expected error ${e.toString()}');
    }
  }

  _getAllTablesFromDb(
      GetAllTablesEvent event, Emitter<DbRemoteState> emit) async {
    try {
      // emit(LoudingState());
      final res = await AppGetter.httpSrv
          .getData(DbRemoteSubUrl.getAllTables.subRoute, isAuth: true);

      final deCodeData = jsonDecode(res.data);

      if (res.status == ResultsLevel.fail) {
        final newErrorMsg = deCodeData['msg'] ?? 'error to get All Tables**';
        AppGetter.appLogger.showLogger(LogLevel.error, newErrorMsg);
        emit(GetAllTablesState(error: newErrorMsg));
        return;
      }
      emit(GetAllTablesState(tables: deCodeData['data']));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(GetAllTablesState(error: 'Un handel error while get tables'));
    }
  }
}
