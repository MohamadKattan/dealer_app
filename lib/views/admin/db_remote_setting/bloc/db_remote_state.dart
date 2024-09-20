abstract class DbRemoteState {}

class Inite extends DbRemoteState {}

class LoudingState extends DbRemoteState {}

class ClickCreateTableState extends DbRemoteState {
  bool? isClicked;

  ClickCreateTableState({this.isClicked});
}

class CancleCreateTableState extends DbRemoteState {
  bool? isClicked;
  CancleCreateTableState({this.isClicked});
}

class AddNewColumnState extends DbRemoteState {}

class RemoveOneColumnState extends DbRemoteState {}

class RefreshTableState extends DbRemoteState {}

class SaveTableOnRemoteDbState extends DbRemoteState {
  String? error;
  String? msg;
  SaveTableOnRemoteDbState({this.error, this.msg});
}

class GetAllTablesState extends DbRemoteState {
  String? error;
  List? tables;
  GetAllTablesState({this.error, this.tables});
}

class TruncateTableState extends DbRemoteState {
  String? msg;
  TruncateTableState({this.msg});
}

class DeleteTableState extends DbRemoteState {
  String? msg;
  DeleteTableState({this.msg});
}

class ShowTableInfoState extends DbRemoteState {
  String? msg;
  String? tableName;
  List? data;
  ShowTableInfoState({this.tableName, this.msg, this.data});
}

class DeleteOneColumnState extends DbRemoteState {
  String? msg;
  DeleteOneColumnState({this.msg});
}
