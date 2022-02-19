import 'dart:convert';

List<TodosModels> todosModelsFromJson(String str) => List<TodosModels>.from(
    json.decode(str).map((x) => TodosModels.fromJson(x)));

String todosModelsToJson(List<TodosModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodosModels {
  TodosModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory TodosModels.fromJson(Map<String, dynamic> json) => TodosModels(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
