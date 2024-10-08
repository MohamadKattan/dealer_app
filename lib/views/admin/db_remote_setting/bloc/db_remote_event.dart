abstract class DbRemoteEvent {}

class ClickCreateTableEvent extends DbRemoteEvent {}

class CancleCreateTableEvent extends DbRemoteEvent {}

class AddNewColumnEvent extends DbRemoteEvent {}

class RemoveOneColumnEvent extends DbRemoteEvent {}

class RefreshAllTablesEvent extends DbRemoteEvent {}

class SaveTableOnRemoteDbEvent extends DbRemoteEvent {
  String tableName;
  List listColumn;
  SaveTableOnRemoteDbEvent({required this.tableName, required this.listColumn});
}

class GetAllTablesEvent extends DbRemoteEvent {}

class TruncateTableEvent extends DbRemoteEvent {
  String tableName;
  TruncateTableEvent(this.tableName);
}

class DeleteTableEvent extends DbRemoteEvent {
  String? tableName;
  DeleteTableEvent(this.tableName);
}

class ShowTableInfoEvent extends DbRemoteEvent {
  String tableName;
  ShowTableInfoEvent(this.tableName);
}

class DeleteOneColumnEvent extends DbRemoteEvent {
  String tableName;
  String columnName;
  DeleteOneColumnEvent(this.tableName, this.columnName);
}

class EditTableOrColumnEvent extends DbRemoteEvent {
  String tableName;
  bool isEditTable;
  Object oneColum;
  EditTableOrColumnEvent(this.tableName, this.oneColum, this.isEditTable);
}

class DevOptionsDbEvent extends DbRemoteEvent {
  String pass;
  String text;
  String url;
  DevOptionsDbEvent(
      {required this.pass, required this.text, required this.url});
}
