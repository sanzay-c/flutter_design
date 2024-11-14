import 'dart:convert';

class DrfModel {
  int id;
  String name;
  String description;
  String status;

  DrfModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory DrfModel.fromRawJson(String str) =>
      DrfModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // From JSON Map to Model
  factory DrfModel.fromJson(Map<String, dynamic> json) => DrfModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
      );

  // Convert TodoModel to JSON Map
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
      };
}
