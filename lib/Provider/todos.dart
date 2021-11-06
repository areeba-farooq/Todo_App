import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todoList = [ //private
    TodoModel(
        createdTime: DateTime.now(),
        title: 'Buy Food',
        description: '-Eggs\n-Milk\n-Bread\n-Oil'
    ),
    TodoModel(
        createdTime: DateTime.now(),
        title: 'Read a book',
        description: '2 Pages today'
    ),
    TodoModel(
        createdTime: DateTime.now(),
        title: 'Parlour appointment',
        description: 'Saturday at 5 pm'
    ),
    TodoModel(
        createdTime: DateTime.now(),
        title: 'Go for a walk',
        description: 'Daily 2km at 4 pm'
    ),
    TodoModel(
        createdTime: DateTime.now(),
        title: 'Shopping List',
        description: '-Watch\n-Rings pack\n-2 casual dresses\n-nail paints'
    ),
  ];

//to make this public,
// so we created a getter => go over all of our _Todos and filter them,
  //only the right todos display
  List<TodoModel> get todosList =>
      _todoList.where((todoL) => todoL.isDone == false).toList();

  List<TodoModel> get todosCompleted =>
      _todoList.where((todoL) => todoL.isDone == true).toList();

  //adding todos method
  void addTodo(TodoModel newTodo) {
    _todoList.add(newTodo); //adding user todos to todoList

    //by calling this our provider need to update our UI
    notifyListeners();
  }

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
}