import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

class Utils{

  static void showSnackBar(BuildContext context, String text){
    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));
  }
  //and we transfer back that json to our datetime object
  static DateTime toDateTime(Timestamp value){
    return value.toDate();
  }

  //this transfer data into json
  static dynamic fromDateTimeToJson(DateTime date){

    return date.toLocal();
  }

  static StreamTransformer transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );
}