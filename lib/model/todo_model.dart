import 'package:flutter/material.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class TodoModel {
  late DateTime createdTime;
  late String title;
  late final id;
  late String description;
  late bool isDone;

  TodoModel({
    required this.createdTime,
    this.description= "",
    required this.title,
    this.id,
    this.isDone = false,
});
}