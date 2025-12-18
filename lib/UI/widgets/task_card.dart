import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/task_model.dart';
import '../providers/task_card_provider.dart';
import 'snack_bar_message.dart';
import 'circular_progress.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.refreshList,
  });

  final TaskModel taskModel;

  //for refreshing the task list after deletion
  final VoidCallback refreshList;


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCardProvider>(
      builder: (context, taskCardProvider, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ListTile(
            tileColor: Colors.white,
            title: Text(taskModel.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.description,
                  style: TextStyle(color: Colors.grey),
                ),
                Text('Date: ${taskModel.createdDate}'),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusBarColor(taskModel.status),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        taskModel.status,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible:taskCardProvider.deleteInProgress == false,
                      replacement: Center(child: CenteredCircularProgress()),
                      child: IconButton(
                        onPressed: () {
                          showDeleteConfirmationDialog(context);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                    Visibility(
                      visible: taskCardProvider.changeStatusInProgress == false,
                      replacement: Center(child: CenteredCircularProgress()),
                      child: IconButton(
                        onPressed: () {
                          _showChangeStatusDialog(context, taskCardProvider);
                        },
                        icon: Icon(Icons.edit, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _showChangeStatusDialog(
      BuildContext context,
      TaskCardProvider taskCardProvider,
      ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Task Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: _isCurrentStatus('New') ? Icon(Icons.done) : null,
                onTap: () {
                  _onTapChangeTaskTile('New',context);
                },
              ),
              ListTile(
                title: Text('Progress'),
                trailing: _isCurrentStatus('Progress')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Progress',context);
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                trailing: _isCurrentStatus('Cancelled')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Cancelled',context);
                },
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _isCurrentStatus('Completed')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Completed',context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Check if the given status is the current status of the task
  bool _isCurrentStatus(String status) {
    return taskModel.status == status;
  }

  // Handle tap on change task tile
  void _onTapChangeTaskTile(String status,BuildContext context) {
    if (_isCurrentStatus(status)) return;
    Navigator.pop(context);
    _chngeStatus(status,context);
  }

  // Change the status of the task
  Future<void> _chngeStatus(String status, BuildContext context) async {

    final provider = Provider.of<TaskCardProvider>(context, listen: false);
    final bool successed = await provider.chngeStatus(taskModel.id, status);
    if(!context.mounted) return;

    if (successed) {
      showSnackBarMessage(context, 'Task status changed to $status'); //comment
      refreshList();
    } else {
      showSnackBarMessage(
        context,
        'Failed to change task status ${provider.errorMessage}',
      );
    }
  }

  // Get the color for the status bar based on the task status
  Color _getStatusBarColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Progress':
        return Colors.amber;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }

  //Delet Task Functions
  Future<void> _deleteTask(String taskId, BuildContext context) async {
    final provider = Provider.of<TaskCardProvider>(context, listen: false);
    final bool successed =await provider.deleteTask(taskId);
    if(!context.mounted) return;

    if (successed) {
      showSnackBarMessage(context, 'Task deleted successfully');

      refreshList();
    } else {
      showSnackBarMessage(
        context,
        'Failed to delete task: ${provider.errorMessage}',
      );
    }
  }

  // Delete confirmation dialog
  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close the dialog
            },
            child: Text('Cancel'),
          ),

          TextButton(
            onPressed: () {
              _deleteTask(taskModel.id,context);
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Delete'),
          ),

        ],
      );
    });
  }
}
