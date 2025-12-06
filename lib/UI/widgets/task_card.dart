import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_count_model.dart';
import '../../data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'snack_bar_message.dart';
import 'circular_progress.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.refreshList,
  });

  final TaskModel taskModel;

  //for refreshing the task list after deletion
  final VoidCallback refreshList;


  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  // To manage the state of status change operation
  bool _changeStatusInProgress = false;
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(widget.taskModel.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.grey),
            ),
            Text('Date: ${widget.taskModel.createdDate}'),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusBarColor(widget.taskModel.status),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.taskModel.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: _deleteInProgress == false,
                  replacement: Center(child: CenteredCircularProgress()),
                  child: IconButton(
                    onPressed: () {
                      showDeleteConfirmationDialog();
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
                Visibility(
                  visible: _changeStatusInProgress == false,
                  replacement: Center(child: CenteredCircularProgress()),
                  child: IconButton(
                    onPressed: () {
                      _showChangeStatusDialog();
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

  void _showChangeStatusDialog() {
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
                  _onTapChangeTaskTile('New');
                },
              ),
              ListTile(
                title: Text('Progress'),
                trailing: _isCurrentStatus('Progress')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Progress');
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                trailing: _isCurrentStatus('Cancelled')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Cancelled');
                },
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _isCurrentStatus('Completed')
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Completed');
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
    return widget.taskModel.status == status;
  }

  // Handle tap on change task tile

  void _onTapChangeTaskTile(String status) {
    if (_isCurrentStatus(status)) return;
    Navigator.pop(context);
    _chngeStatus(status);
  }

  // Change the status of the task
  Future<void> _chngeStatus(String status) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.changeTaskStatusUrl(widget.taskModel.id, status),
    );
    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task status changed to $status'); //comment
      widget.refreshList();
    } else {
      showSnackBarMessage(
        context,
        'Failed to change task status ${response.errorMassage}',
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
  Future<void> _deleteTask(String taskId) async {
    _deleteInProgress = true;
    setState(() {});
    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.deleteTaskById(taskId),
    );
    _deleteInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task deleted successfully');

      widget.refreshList();
    } else {
      showSnackBarMessage(
        context,
        'Failed to delete task: ${response.errorMassage}',
      );
    }
  }

  // Delete confirmation dialog
  void showDeleteConfirmationDialog() {
    showDialog(context: context, builder: (_){
      return AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),

          TextButton(
            onPressed: () {
              _deleteTask(widget.taskModel.id);
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Delete'),
          ),

        ],
      );
    });
  }
}
