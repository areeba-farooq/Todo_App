import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
final List<TodoModel> _todoList = [  //private
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
      title: 'Buy a gift for dad',
      description: '-Watch\n-Shirt\n-Perfume\n-Flowers'
  ),
  TodoModel(
      createdTime: DateTime.now(),
      title: 'Go for walk',
      description: '2km in Evening'
  ),
  TodoModel(
      createdTime: DateTime.now(),
      title: 'Learn Flutter',
      description: '2 hours daily'
  ),
  TodoModel(
      createdTime: DateTime.now(),
      title: 'Buy some clothes',
      description: '-2 for nightwear\n-3 casual\n-1 fancy'
  ),
];
//to make this public,
// so we created a getter => go over all of our _Todos and filter them,
  //only the right todos display
List<TodoModel> get todosList => _todoList.where((todoL) => todoL.isDone == false).toList();
}