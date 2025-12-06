import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';

import '../../../data/utils/urls.dart';
import '../../widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCancelledTaskListInProgress == false,
        replacement: Center(child: CenteredCircularProgress()),
        child: ListView.separated(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _cancelledTaskList[index],
              refreshList: () {
                _getCancelledTaskList();
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.cancleTasksUrl,
    );
    if(response.isSuccess){
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
