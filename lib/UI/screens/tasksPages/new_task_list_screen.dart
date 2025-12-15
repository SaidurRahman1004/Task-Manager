import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/task_card.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import '../../../data/models/task_count_model.dart';
import '../../providers/new_task_list_provider.dart';
import '../../widgets/circular_progress.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {      Provider.of<NewTaskListProvider>(context, listen: false).getNewTaskList();
    Provider.of<NewTaskListProvider>(context, listen: false).getTaskCountList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final newTaskListprovider = NewTaskListProvider();
          newTaskListprovider.getNewTaskList();
          newTaskListprovider.getTaskCountList();

        },
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              SizedBox(),
              _buildTaskSummaryListView(),
              Consumer<NewTaskListProvider>(
                builder: (context, newTaskListprovider, child) {
                  if (newTaskListprovider.listInProgress) {
                    return CenteredCircularProgress();
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      return TaskCard(
                        taskModel: newTaskListprovider.newTaskList[index],
                        refreshList: () {
                          newTaskListprovider.getNewTaskList();
                          newTaskListprovider.getTaskCountList();
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(height: 8);
                    },
                    itemCount: newTaskListprovider.newTaskList.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, '/newTask').then((_) {
      final newTaskListprovider = NewTaskListProvider();
      Provider.of<NewTaskListProvider>(context,listen: false).getNewTaskList();
      Provider.of<NewTaskListProvider>(context,listen: false).getTaskCountList();
      // newTaskListprovider.getTaskCountList();
      // newTaskListprovider.getNewTaskList();
    });
  }

  //Sumury Card
  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: Consumer<NewTaskListProvider>(
        builder: (context, newTaskListprovider, child) {
          return Visibility(
            visible: newTaskListprovider.countInProgress == false,
            replacement: CenteredCircularProgress(),
            child: ListView.builder(
              itemCount: newTaskListprovider.taskCountList.length,
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
                          newTaskListprovider.taskCountList[index].sum
                              .toString(),
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(
                          newTaskListprovider.taskCountList[index].id,
                          style: TextTheme.of(context).labelSmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
