import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Provider/todos.dart';
import 'package:todo_app/Widgets/todo_list.dart';

class CompletedList extends StatefulWidget {
  const CompletedList({Key? key}) : super(key: key);

  @override
  _CompletedListState createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todosCompleted;
    return todos.isEmpty?
    const Center(
      child: Text('No Completed tasks!', style: TextStyle(
          color: color1,
          fontWeight: FontWeight.w500,
          fontFamily: 'CrimsonText',
          fontSize: 25
      ),),
    )
        :
    ListView.separated(
        separatorBuilder: (context, index)=> Container(height: 8,),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: todos.length,
        itemBuilder: (context, index){
          final allTodos = todos[index];
          return TodoCard(
              todo: allTodos);
        }
    );
  }
}
