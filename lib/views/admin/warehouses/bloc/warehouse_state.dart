import 'package:dealer/views/admin/warehouses/model/warehouse_model.dart';

abstract class WarehouseState {}

class InitialState extends WarehouseState {
  String? msg;
  InitialState({this.msg});
}

class FormSubmitState extends WarehouseState {
  String? msg;
  bool? isForEidet;
  int? id;
  String? oldName;
  String? oldDes;
  FormSubmitState(
      {this.msg, this.isForEidet, this.id, this.oldName, this.oldDes});
}

class ErrorWarehousesState extends WarehouseState {
  String msg;
  ErrorWarehousesState(this.msg);
}

class GetWarehousesState extends WarehouseState {
  List<WarehouseModel> warehouses;
  GetWarehousesState(this.warehouses);
}
