// ignore: file_names
import 'dart:convert';

import 'package:latihan_pagination/models/todosModels.dart';
import 'package:http/http.dart' as http;

class todosController {
  static Future<List<TodosModels>?> getTodos(http.Client client) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var list = ParsedResponse(response.body);

      return list;
    }
  }

  // ignore: non_constant_identifier_names
  static List<TodosModels> ParsedResponse(String responBody) {
    var jsonResponse = json.decode(responBody).cast<Map<String, dynamic>>();

    return jsonResponse
        .map<TodosModels>((json) => TodosModels.fromJson(json))
        .toList();
  }

  static Future<List<TodosModels>?> getScroll(int offset, int limit) async {
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/todos?offset=$offset&limit=$limit');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var list = ParsedResponse(response.body);

      return list;
    }
  }
}
