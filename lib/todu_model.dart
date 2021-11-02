import 'dart:convert';

class TodoModel {
  TodoModel({
    required this.description,
    this.iscompelete = false,
  });

  String description;
  bool iscompelete;

  static List<TodoModel> todoLitsFromJson(String str) =>
      List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromMap(x)));

  static String todolistTojson(List<TodoModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

  factory TodoModel.fromJson(String str) => TodoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        description: json["description"],
        iscompelete: json["iscompelete"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "iscompelete": iscompelete,
      };
}
