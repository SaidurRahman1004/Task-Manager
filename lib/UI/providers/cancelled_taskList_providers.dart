import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class CancleTaskProvider extends ChangeNotifier {
  bool _getCancelledTaskListInProgress = false;
  String? _listErrorMessage;
  List<TaskModel> _cancelledTaskList = [];

  bool get getCancelledTaskListInProgress => _getCancelledTaskListInProgress;
  String? get listErrorMessage => _listErrorMessage;

  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.cancleTasksUrl,
    );
    _getCancelledTaskListInProgress = false;
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
      _listErrorMessage = null;
      notifyListeners();
      return true;
    } else {
      _listErrorMessage= response.errorMassage;
      notifyListeners();
      return false;

    }


  }
}
