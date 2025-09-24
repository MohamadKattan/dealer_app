enum WarehouseJsonType { create, edite, delete }

class WarehouseModel {
  int? id;
  String? name;
  String? des;

  WarehouseModel({this.id, this.name, this.des});

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(id: map['id'], name: map['name'], des: map['des']);
  }

  Map<String, dynamic> toJson(WarehouseJsonType type) {
    switch (type) {
      case WarehouseJsonType.create:
        return {'name': name, 'des': des ?? 'No Info'};

      case WarehouseJsonType.edite:
        return {"id": id, 'name': name, 'des': des ?? 'No Info'};
      case WarehouseJsonType.delete:
        return {"id": id};
      default:
        return {};
    }
  }
}
