import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/todos.dart';
import 'package:todo_app/Widgets/todo_form.dart';
import 'package:todo_app/model/todo_model.dart';

import '../Constants/constants.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final globalkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: globalkey,
          child: Column(
            mainAxisSize: MainAxisSize.min ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add To-Do', style: TextStyle(
                fontSize: 25,
                color: color1,
                fontWeight: FontWeight.bold,
                fontFamily: 'CrimsonText'
              ),),
              const SizedBox(height: 10,),
              TodoForm(
                //got the title form todoform
                onChangedTitle: (title){
                  setState(() {
                    //and stored every title in the above variable title = '';
                    this.title = title;
                  });
                  },
                  onChangedDescription: (description){
                    setState(() {
                      this.description = description;
                    });
                  },
                  onSaved: addTodo,
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  void addTodo() {
    final isValid = globalkey.currentState!.validate();
    if(!isValid){
      return;
    }else{
      //created newTodo that can user add their title and description in the dialog box
        final newTodo = TodoModel(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      //add the user todos in the provider todos List
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.addTodo(newTodo);

      //after adding todos we want to hide this dialog.
      Navigator.of(context).pop();
    }
  }
}
