import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';

import '../../widgets/task_card.dart';
import '../../../data/models/task_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getProgressTaskListInProgress == false,
        replacement: Center(child: CenteredCircularProgress(),),
        child: ListView.separated(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
                taskModel: _progressTaskList[index],
                refreshList: (){
                  _getProgressTaskList();
            });
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.progressTasksUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      showSnackBarMessage(
          context, response.errorMessage
      );
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
