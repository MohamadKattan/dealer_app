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
