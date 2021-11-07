import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class TodoModel {
  late DateTime createdTime;
  late String title;
  late String? id;
  late String description;
  late bool isDone;

  TodoModel({
    required this.createdTime,
    this.description = "",
    required this.title,
    this.id,
    this.isDone = false,
  });

  //transferred this data from firebase to our todomodel
  static TodoModel fromJson(Map<String, dynamic> json) => TodoModel(
    createdTime:  Utils.toDateTime(json['createdTime']),
    title: json['title'],
    description:  json['description'],
    id: json['id'],
    isDone: json['isDone'],
  );

  //our data to firebase
  Map<String, dynamic> toJson() =>
      {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}