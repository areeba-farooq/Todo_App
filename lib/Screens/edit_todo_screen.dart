import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Constants/constants.dart';
import 'package:todo_app/Provider/todos.dart';
import 'package:todo_app/Widgets/todo_form.dart';
import 'package:todo_app/model/todo_model.dart';

class EditTodoPage extends StatefulWidget {
  final TodoModel todo;
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late  String title;
  late String description;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //we will get our todos title and description from todoModel todos
    //we have here initial value of title and description.
    title = widget.todo.title;
    description = widget.todo.description;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Edit Todo'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: TodoForm(
            title: title,
            description: description,
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
            onSaved: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    } else{
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);// we want to update the existing todos

      Navigator.of(context).pop();
    }
  }
}
