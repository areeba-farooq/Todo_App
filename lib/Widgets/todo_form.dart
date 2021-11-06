import 'package:flutter/material.dart';

import '../Constants/constants.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedDescription,
    required this.onChangedTitle,
    required this.onSaved}) : super(key: key);
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          TextFormField(
            maxLines: 1,
            onChanged: onChangedTitle,
            validator: (title){
              if(title!.isEmpty){
                return 'The title cannot be empty';
              }
              return null;
            },
            initialValue: title,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(
                color: color1
              ),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color1)
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color1)
              )
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            maxLines: 3,
            onChanged: onChangedDescription,
            validator: (description){
              if(description!.isEmpty){
                return 'The description cannot be empty';
              }
              return null;
            },
            initialValue: description,
            decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                    color: color1
                ),
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color1)
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color1)
                )
            ),
          ),
          const SizedBox(height: 50,),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                onPressed: onSaved,
                child: const Text('Save', style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CrimsonText',
                  fontSize: 23
                ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color1)
              ),
            ),
          )

        ],
      ),

    );
  }
}
