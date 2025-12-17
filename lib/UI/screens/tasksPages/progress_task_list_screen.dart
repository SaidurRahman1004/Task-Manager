import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import '../../providers/progress_task_list_provider.dart';
import '../../widgets/task_card.dart';


class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProgressTaskListProvider>(context,listen: false).getProgressTaskList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProgressTaskListProvider>(
        builder: (context,progressProvider, child) {
          return Visibility(
            visible: progressProvider.getProgressTaskListInProgress == false,
            replacement: Center(child: CenteredCircularProgress(),),
            child: RefreshIndicator(
              onRefresh: () async{
                Provider.of<ProgressTaskListProvider>(context,listen: false).getProgressTaskList();
              },
              child: ListView.separated(
                itemCount: progressProvider.progressTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                      taskModel: progressProvider.progressTaskList[index],
                      refreshList: (){
                        Provider.of<ProgressTaskListProvider>(context,listen: false).getProgressTaskList();
                  });
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
