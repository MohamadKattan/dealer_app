abstract class WarehousesEvent {}

class InitialEvent extends WarehousesEvent {}

class ShowFormSubmitEvent extends WarehousesEvent {
  bool? isEdite;
  int? id;
  String? oldName;
  String? oldDes;
  ShowFormSubmitEvent({this.isEdite, this.id, this.oldName, this.oldDes});
}

class CreateWarehouseEvent extends WarehousesEvent {
  String? name;
  String? des;
  CreateWarehouseEvent({this.name, this.des});
}

class DeleteWarehousEvent extends WarehousesEvent {
  int id;
  DeleteWarehousEvent(this.id);
}

class EditeWarehouseEvent extends WarehousesEvent {
  int? id;
  String? oldName;
  String? oldDes;
  String? newName;
  String? newDes;

  EditeWarehouseEvent(
      {this.id, this.oldName, this.oldDes, this.newName, this.newDes});
}
