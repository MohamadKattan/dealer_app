class DbRemoteModel {
  String? tableName;
  List? listOfColumns;
  List? listOfTables;
  DbRemoteModel({this.tableName, this.listOfColumns, this.listOfTables});

  factory DbRemoteModel.fromJson(Map<String, dynamic> map) {
    return DbRemoteModel(listOfTables: map['data']);
  }

  Map<String, dynamic> toJson() {
    return {"tableName": tableName, "columns": listOfColumns};
  }
}
