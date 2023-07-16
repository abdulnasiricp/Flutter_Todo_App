// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:firebase_notification/model/todoModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  var todoList = RxList<TodoModel>();

  RxBool isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTodoList();
  }

  //get todo
  Future<RxList<TodoModel>> getTodoList() async {
    isloading.value = true;
    final response = await http
        .get(Uri.parse('https://64b28ad538e74e386d553c36.mockapi.io/mytodo'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        todoList.add(TodoModel.fromJson(index));
      }
      isloading.value = false;
      return todoList;
    } else {
      return todoList;
    }
  }

  //post todo
  Future<void> postTodo(title, desc) async {
    isloading.value=true;
    final response = await http.post(
        Uri.parse('https://64b28ad538e74e386d553c36.mockapi.io/mytodo'),
        headers: {'content-type': 'application/json'},
        body: json.encode({'title': title, 'desc': desc}));

    if (response.statusCode == 201) {
      todoList.clear();
      print('Done');
      getTodoList();
      isloading.value=false;
    } else {
      print('Faild');
    }
  }

  //delete todo

  Future<void> deleteTodo(id) async {
    isloading.value=true;
    final response = await http.delete(
      Uri.parse('https://64b28ad538e74e386d553c36.mockapi.io/mytodo/$id'),
      
    );

    if (response.statusCode == 200) {
      todoList.clear();
      print('Done');
      getTodoList();
      isloading.value=false;
    } else {
      print('Faild');
    }
  }


}
