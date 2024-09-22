enum TypeJson { createNewTable, onlyTableName, deleteOneColumn, editTable }

class DbRemoteModel {
  String? tableName;
  String? oneColumnName;
  List? listOfColumns;
  List? listOfTables;
  Object? oneColumObj;
  DbRemoteModel(
      {this.tableName,
      this.listOfColumns,
      this.listOfTables,
      this.oneColumnName,
      this.oneColumObj});

  factory DbRemoteModel.fromJson(Map<String, dynamic> map) {
    return DbRemoteModel(listOfTables: map['data']);
  }

  Map<String, dynamic> toJson(TypeJson type) {
    switch (type) {
      case TypeJson.createNewTable:
        return {"tableName": tableName, "columns": listOfColumns};
      case TypeJson.onlyTableName:
        return {"tableName": tableName};
      case TypeJson.deleteOneColumn:
        return {
          "tableName": tableName,
          "oneColumn": {"name": oneColumnName}
        };
      case TypeJson.editTable:
        return {"tableName": tableName, "oneColumn": oneColumObj};
      default:
        return {"tableName": tableName, "columns": listOfColumns};
    }
  }
}
