import 'package:flutter/material.dart';
import 'package:todo_app/Classes/todo_form.dart';

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
                onSaved: (){}
            )
          ],
        ),
      ),
    );
  }
}
