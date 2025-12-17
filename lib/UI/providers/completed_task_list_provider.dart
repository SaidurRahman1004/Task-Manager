import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskListProvider extends ChangeNotifier {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];
  String? _completedErrorMsg;

  bool get getCompletedTaskListInProgress => _getCompletedTaskListInProgress;

  String? get completedErrorMsg => _completedErrorMsg;

  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    _getCompletedTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.completedTasksUrl,
    );
    _getCompletedTaskListInProgress = false;
    if (response.isSuccess) {
      _completedTaskList = (response.body['data'] as List).map((jsonData) =>
          TaskModel.fromJson(jsonData)).toList();
      _completedErrorMsg = null;
      notifyListeners();
      return true;
    }
    else{
      _completedErrorMsg = response.errorMassage;
      notifyListeners();
      return false;
    }
  }


}