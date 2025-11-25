import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/task_card.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../../data/models/task_count_model.dart';
import '../../widgets/circular_progress.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getNewTaskListInProgress = false;
  bool _getTaskCountInProgress = false;

  List<TaskModel> _newTaskList = [];
  List<TaskCountModel> _taskCountList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountList();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(),
            _buildTaskSummaryListView(),
            Visibility(
              visible: _getNewTaskListInProgress == false,
              replacement: SizedBox(
                height: 200,
                child: Center(child: CenteredCircularProgress()),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_, index) {
                  return TaskCard(
                    taskModel: _newTaskList[index],
                    refreshList: () {
                      _getNewTaskList();
                      _getTaskCountList();

                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 8);
                },
                itemCount: _newTaskList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, '/newTask');
  }

  //Sumury Card
  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: Visibility(
        visible: _getTaskCountInProgress == false,
        replacement: CenteredCircularProgress(),
        child: ListView.builder(
          itemCount: _taskCountList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Card(
              elevation: 0,
              color: Colors.white,
              margin: EdgeInsets.only(left: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      _taskCountList[index].sum.toString(),
                      style: TextTheme.of(context).titleMedium,
                    ),
                    Text(
                      _taskCountList[index].id,
                      style: TextTheme.of(context).labelSmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.newTaskUrl,
    );

    if (response.isSuuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMassage);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _getTaskCountList() async {
    _getNewTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.takCountUrl,
    );

    if (response.isSuuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _taskCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMassage);
    }
    _getTaskCountInProgress = false;
    setState(() {});
  }
}
