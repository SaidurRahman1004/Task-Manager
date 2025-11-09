import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

import '../widgets/appbar_custom.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Text("Add New Task",style: TextTheme.of(context).titleLarge,),
              SizedBox(height: 8.0,),
              TextFormField(decoration: InputDecoration(hintText: 'Title'),),
              TextFormField(maxLines: 5,decoration: InputDecoration(hintText: 'Description'),),
              SizedBox(height: 8,),
              FilledButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined),),

              
            ],
          ),
        ),
      ),),
    );
  }
}
