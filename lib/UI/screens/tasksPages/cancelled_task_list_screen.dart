import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import '../../providers/cancelled_taskList_providers.dart';
import '../../widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<CancleTaskProvider>(context,listen: false).getCancelledTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CancleTaskProvider>(
        builder: (context,cancleProvider,child) {
          return Visibility(
            visible: cancleProvider.getCancelledTaskListInProgress == false,
            replacement: Center(child: CenteredCircularProgress()),
            child: RefreshIndicator(
              onRefresh: () async{
                Provider.of<CancleTaskProvider>(context,listen: false).getCancelledTaskList();
              },
              child: ListView.separated(
                itemCount: cancleProvider.cancelledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: cancleProvider.cancelledTaskList[index],
                    refreshList: () {
                      Provider.of<CancleTaskProvider>(context,listen: false).getCancelledTaskList();
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
