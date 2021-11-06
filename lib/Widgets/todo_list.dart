import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Provider/todos.dart';
import 'package:todo_app/Screens/edit_todo_screen.dart';
import 'package:todo_app/Widgets/completed_list.dart';
import 'package:todo_app/Widgets/utils.dart';

import '../model/todo_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //access provider instance
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todosList;
    return todos.isEmpty?
        const Center(
          child: Text('No Todos', style: TextStyle(
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

class TodoCard extends StatelessWidget {
  const TodoCard({required this.todo, Key? key}) : super(key: key);
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          key: Key(todo.id.toString()),
          actions: [
            IconSlideAction(
              color: color2,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              caption: 'Edit',
              onTap: (){
                editTodo(context, todo);
              },
            )
          ],
          secondaryActions: [
              IconSlideAction(
                color: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                caption: 'delete',
                onTap: (){
                  deleteTodo(context, todo );
                },
              )
          ],
          child: Container(
            padding: const EdgeInsets.all(20),
            color: color2.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: color1,
                  checkColor: Colors.white,
                  value: todo.isDone,
                  onChanged: (_) {
                    final provider = Provider.of<TodoProvider>(context, listen: false);
                    final isDone = provider.toggleTodoState(todo);
                    Utils.showSnackBar(context,
                    isDone? 'Task completed!' : 'Task marked incomplete!'
                    );
                  },
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'CrimsonText',
                          fontWeight: FontWeight.bold,
                          color: color1),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          todo.description,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'CrimsonText', height: 1.8),
                        ),
                      )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }


  void deleteTodo(BuildContext context, TodoModel todo) {
    //create provider instance
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo);

    //utils class show the snack bar texts
    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, TodoModel todo) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditTodoPage(todo: todo)));
  }
}
