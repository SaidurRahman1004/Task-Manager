import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';

import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  bool _getCopletedTaskListInProgress = false; //to track loading state
  List<TaskModel> _completedTaskList = []; //to store completed tasks

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCopletedTaskListInProgress == false,
        replacement: Center(child: CenteredCircularProgress()),
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _completedTaskList[index],
              refreshList: () {
                _getCompletedTaskList();
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
    ;
  }

  Future<void> _getCompletedTaskList() async {

    // loading started
    _getCopletedTaskListInProgress = true;
    setState(() {});
    // make network call to get completed tasks
    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.completedTasksUrl,
    );
    //if success, parse data and update list of completed tasks
    if(response.isSuccess){
      //temporary list to store fetched tasks
      List<TaskModel> list = [];
      //iterating through each task data in response
      for(Map<String,dynamic> jsonData in response.body['data']){
        //parsing json to TaskModel and adding to list
        list.add(TaskModel.fromJson(jsonData));
      }
      //updating state variable with fetched tasks
      _completedTaskList = list;
    }else{
      //if error, show snackbar with error message
      showSnackBarMessage(context, response.errorMassage);
    }
    // loading ended
    _getCopletedTaskListInProgress = false;
    setState(() {});




  }
}
