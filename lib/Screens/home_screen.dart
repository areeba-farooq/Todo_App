import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/API%20Services/firebase_api.dart';
import 'package:todo_app/Provider/todos.dart';
import 'package:todo_app/Widgets/add_todo.dart';
import 'package:todo_app/Widgets/completed_list.dart';
import 'package:todo_app/Widgets/todo_list.dart';
import 'package:todo_app/model/todo_model.dart';

import '../Constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      //appears todos
      const TodoList(),
      //appears completed todos
      const CompletedList(),
    ];
    return Scaffold(
      appBar: AppBar(
       backgroundColor: color1,
        title: const Text('To Do'),
        leading: const Icon(Icons.person, color: Colors.white,),
      ),
      //these two tabs appears
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color1,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined, color: Colors.white,),
            label: 'Todos'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, color: Colors.white, size: 28,),
              label: 'Completed'
          )
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => const AddTodo(),
            barrierDismissible: false,
          );
        },
        backgroundColor: color2,
      ),

      //using stream builder to get the todos from the server
      body: Column(
        children: [
          StreamBuilder<List<TodoModel>>(
            stream: FirebaseApi.readTodos(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final todos = snapshot.data;

                    final provider = Provider.of<TodoProvider>(context);
                    provider.setTodos(todos!);

                    return tabs[selectedIndex];
                  }
              }
            },
          ),
        ],
      ),

    );
  }
  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: const TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
