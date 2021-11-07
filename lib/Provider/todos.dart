import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/API%20Services/firebase_api.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todoList = [];

//to make this public,
// so we created a getter => go over all of our _Todos and filter them,
  //only the right todos display
  List<TodoModel> get todosList =>
      _todoList.where((todoL) => todoL.isDone == false).toList();

  List<TodoModel> get todosCompleted =>
      _todoList.where((todoL) => todoL.isDone == true).toList();



  
  //adding todos method
  //this will stored our todos data locally and within firebase as well
  void addTodo(TodoModel newTodo) => FirebaseApi.createTodo(newTodo);

    // _todoList.add(newTodo); adding user todos to todoList
    //
    //by calling this our provider need to update our UI
    // notifyListeners();
  

  //removing todos method
  void removeTodo(TodoModel todo) {
    _todoList.remove(todo);

    notifyListeners();
  }

  //toggle between completed or in completed todos method
  toggleTodoState(TodoModel todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }
//Update our existing todos in edit page.
  void updateTodo(TodoModel todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    //to update this in our UI
    notifyListeners();
  }

  void setTodos(List<TodoModel> todos) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _todoList = todos;
      notifyListeners();
    });
  }
}