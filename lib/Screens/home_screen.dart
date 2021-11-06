import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/add_todo.dart';
import 'package:todo_app/Widgets/completed_list.dart';
import 'package:todo_app/Widgets/todo_list.dart';

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
      body: tabs[selectedIndex],

    );
  }
}
