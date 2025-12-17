import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import '../../providers/completed_task_list_provider.dart';
import '../../widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
 // final _completedProvider = CompletedTaskListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<CompletedTaskListProvider>(context).getCompletedTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompletedTaskListProvider>(
        builder: (context,completedProvider,child) {
          return Visibility(
            visible: completedProvider.getCompletedTaskListInProgress == false,
            replacement: Center(child: CenteredCircularProgress()),
            child: RefreshIndicator(
              onRefresh: () async {
                Provider.of<CompletedTaskListProvider>(context).getCompletedTaskList();
              },
              child: ListView.separated(
                itemCount: completedProvider.completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: completedProvider.completedTaskList[index],
                    refreshList: () {
                      Provider.of<CompletedTaskListProvider>(context).getCompletedTaskList();
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
      ),
    );

  }
}
