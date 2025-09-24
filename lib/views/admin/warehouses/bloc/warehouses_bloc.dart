import 'dart:convert';

import 'package:dealer/models/results_controller.dart';
import 'package:dealer/utilities/dev_helper/app_getter.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouse_state.dart';
import 'package:dealer/views/admin/warehouses/bloc/warehouses_event.dart';
import 'package:dealer/views/admin/warehouses/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SubUrlWarehouses {
  show('showWhouses'),
  create('createWhouses'),
  edite('EditeWhouses'),
  delete('deleteWhouses');

  final String subUrl;
  const SubUrlWarehouses(this.subUrl);
}

class WarehousesBloc extends Bloc<WarehousesEvent, WarehouseState> {
  WarehousesBloc() : super(InitialState()) {
    on<InitialEvent>(_initialSettings);
    on<ShowFormSubmitEvent>(_showSubmitfrom);
    on<CreateWarehouseEvent>(_createWarehouse);
    on<DeleteWarehousEvent>(_deleteWarehouses);
    on<EditeWarehouseEvent>(_editeWareHouse);
  }

  _initialSettings(InitialEvent event, Emitter<WarehouseState> emit) async {
    try {
      ResultController resDB = await AppGetter.httpSrv
          .getData(SubUrlWarehouses.show.subUrl, isAuth: true);

      if (resDB.status == ResultsLevel.fail && resDB.data == null) {
        String? errMsg = resDB.error ?? 'Un handel error';
        emit(ErrorWarehousesState(errMsg));
        AppGetter.appLogger.showLogger(LogLevel.error, errMsg);
        return;
      }

      final data = jsonDecode(resDB.data);

      if (resDB.status == ResultsLevel.fail && resDB.data != null) {
        String? errMsg = data['msg'] ?? 'err';
        emit(ErrorWarehousesState(errMsg!));
        AppGetter.appLogger.showLogger(LogLevel.error, errMsg);
        return;
      }

      if (resDB.status == ResultsLevel.success) {
        List<WarehouseModel> listOfWareHouses = [];
        for (var ele in data['data']) {
          WarehouseModel warehouses = WarehouseModel.fromMap(ele);
          listOfWareHouses.add(warehouses);
        }
        if (listOfWareHouses.isEmpty) {
          AppGetter.appLogger.showLogger(LogLevel.warning, 'No WAREHOUSES');
          emit(GetWarehousesState(listOfWareHouses));
          return;
        }
        AppGetter.appLogger.showLogger(LogLevel.info, 'GOT WAREHOUSES IS OK');
        emit(GetWarehousesState(listOfWareHouses));
      }
    } catch (e) {
      emit(ErrorWarehousesState('Un handel error'));
    }
  }

  _showSubmitfrom(ShowFormSubmitEvent event, Emitter<WarehouseState> emit) {
    if (event.isEdite == true) {
      emit(FormSubmitState(
          isForEidet: true,
          id: event.id,
          oldName: event.oldName,
          oldDes: event.oldDes));
      return;
    }
    emit(FormSubmitState(isForEidet: false));
  }

  _createWarehouse(
      CreateWarehouseEvent event, Emitter<WarehouseState> emit) async {
    if (event.name!.isEmpty) {
      emit(FormSubmitState(msg: 'Warehouse name is required'));
      return;
    }
    if (event.des!.isEmpty) event.des = 'No info';

    WarehouseModel warehouse = WarehouseModel(name: event.name, des: event.des);
    final jsonBody = warehouse.toJson(WarehouseJsonType.create);

    try {
      ResultController resDB = await AppGetter.httpSrv
          .postData(SubUrlWarehouses.create.subUrl, jsonBody, isAuth: true);

      final deCodeBody = jsonDecode(resDB.data);
      if (resDB.status == ResultsLevel.fail) {
        String? errMsg = deCodeBody['msg'] ?? 'err';
        emit(ErrorWarehousesState(errMsg!));
        AppGetter.appLogger.showLogger(LogLevel.error, errMsg);
        return;
      }
      if (resDB.status == ResultsLevel.success) {
        String? msg = deCodeBody['msg'] ?? 'ok => 200';
        AppGetter.appLogger.showLogger(LogLevel.info, msg!);
        emit(InitialState());
        return;
      }
    } catch (e) {
      emit(ErrorWarehousesState('Un handel error'));
    }
  }

  _deleteWarehouses(
      DeleteWarehousEvent event, Emitter<WarehouseState> emit) async {
    WarehouseModel warehouse = WarehouseModel(id: event.id);
    final jsonBody = warehouse.toJson(WarehouseJsonType.delete);

    try {
      ResultController resDB = await AppGetter.httpSrv
          .deleteData(SubUrlWarehouses.delete.subUrl, jsonBody, isAuth: true);
      if (resDB.status == ResultsLevel.fail && resDB.data == null) {
        AppGetter.appLogger.showLogger(
            LogLevel.error, resDB.error ?? 'error while delete warehouse');
        emit(ErrorWarehousesState(
            resDB.error ?? 'error while delete warehouse'));
        return;
      }
      final bodyDecode = jsonDecode(resDB.data);
      if (resDB.status == ResultsLevel.fail && resDB.data != null) {
        String? errMsg = bodyDecode['msg'] ?? 'err';
        AppGetter.appLogger.showLogger(LogLevel.error, errMsg!);
        emit(ErrorWarehousesState(errMsg));
        return;
      }
      String? msg = bodyDecode['msg'] ?? 'ok';
      AppGetter.appLogger.showLogger(LogLevel.info, msg!);
      emit(InitialState(msg: msg));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(ErrorWarehousesState('Un handel error'));
    }
  }

  _editeWareHouse(
      EditeWarehouseEvent event, Emitter<WarehouseState> emit) async {
    String? name;
    String? des;
    if (event.id == null || event.oldName == null || event.oldDes == null) {
      emit(ErrorWarehousesState('error input data'));
      return;
    }
    if (event.newName!.isEmpty) {
      event.newName = event.oldName;
    }

    if (event.newDes!.isEmpty) {
      event.newDes = event.oldDes;
    }

    name = event.newName;
    des = event.newDes;
    
    WarehouseModel warehouse =
        WarehouseModel(id: event.id, name: name, des: des);
    final toJson = warehouse.toJson(WarehouseJsonType.edite);
    try {
      final resDB = await AppGetter.httpSrv
          .putData(SubUrlWarehouses.edite.subUrl, toJson);
      if (resDB.status == ResultsLevel.fail && resDB.data == null) {
        AppGetter.appLogger.showLogger(
            LogLevel.error, resDB.error ?? 'error while edite warehouse');
        emit(
            ErrorWarehousesState(resDB.error ?? 'error while edite warehouse'));
        return;
      }
      final bodyDecode = jsonDecode(resDB.data);
      if (resDB.status == ResultsLevel.fail && resDB.data != null) {
        String? errMsg = bodyDecode['msg'] ?? 'err';
        AppGetter.appLogger.showLogger(LogLevel.error, errMsg!);
        emit(ErrorWarehousesState(errMsg));
        return;
      }
      String? msg = bodyDecode['msg'] ?? 'ok';
      AppGetter.appLogger.showLogger(LogLevel.info, msg!);
      emit(InitialState(msg: msg));
    } catch (e) {
      AppGetter.appLogger.showLogger(LogLevel.error, e.toString());
      emit(ErrorWarehousesState(e.toString()));
    }
  }
}
