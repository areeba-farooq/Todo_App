import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/Widgets/utils.dart';
import 'package:todo_app/model/todo_model.dart';

class FirebaseApi {
 static Future<String> createTodo(TodoModel todoModel) async {
   //collection where you simply store your data
   //doc: you can create multiple documents.
   //and the documents will store everytime one specific 'todos'

   final docTodo = FirebaseFirestore.instance.collection('todo').doc();
   //firebase docs generate an id for us
   //so we put doc id inside our todoModel
   todoModel.id = docTodo.id;

   //creating this docTodo on firebase
   //firebase don't understand our todoModel so we put toJson.
   //firebase will simply stored our todos in firebase documents
   await docTodo.set(todoModel.toJson());
   return docTodo.id;
 }


 static Stream<List<TodoModel>> readTodos() {
     //order them to create the time when todos was created
     FirebaseFirestore.instance
     .collection('todo')
     .orderBy(TodoField.createdTime, descending: true)
     .snapshots()
     //snapshots return a stream of query snapshots we need to transform into our todos object
     .map((event) => Utils.transformer((json) => TodoModel.fromJson(json)));
     return readTodos();
 }
}