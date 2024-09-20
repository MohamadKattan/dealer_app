enum TypeJson { createNewTable, onlyTableName, deleteOneColumn }

class DbRemoteModel {
  String? tableName;
  String? oneColumnName;
  List? listOfColumns;
  List? listOfTables;
  DbRemoteModel(
      {this.tableName,
      this.listOfColumns,
      this.listOfTables,
      this.oneColumnName});

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
      default:
        return {"tableName": tableName, "columns": listOfColumns};
    }
  }
}
