import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import '../widgets/circular_progress.dart';
import '../widgets/snack_bar_message.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

import '../widgets/appbar_custom.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36),
                  Text("Add New Task", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Title'),
                    controller: _titleTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CenteredCircularProgress()),
                    child: FilledButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    //Create Request Body

    Map<String, dynamic> rewuestbody = {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': "New",
    };

    //Call API

    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.createNewTaskUrl,
      body: rewuestbody,
    );
    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuuccess) {
      showSnackBarMessage(context, "Task added successfully");
      _clearTextFields();
    } else {
      showSnackBarMessage(
        context,
        response.errorMassage ?? "Something went wrong",
      );
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
