import 'package:flutter/cupertino.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import '../../data/models/task_model.dart';
import '../../data/utils/urls.dart';

class ProgressTaskListProvider extends ChangeNotifier {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];
  String? _progressErrorMsg;

  bool get getProgressTaskListInProgress => _getProgressTaskListInProgress;

  String? get progressErrorMsg => _progressErrorMsg;

  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.progressTasksUrl,
    );
    _getProgressTaskListInProgress = false;
    if (response.isSuccess) {
      // List<TaskModel> list = [];
      // for (Map<String, dynamic> jsonData in response.body['data']) {
      //   list.add(TaskModel.fromJson(jsonData));
      // }
      // _progressTaskList = list;
      _progressTaskList = (response.body['data'] as List)
          .map((jsonData) => TaskModel.fromJson(jsonData))
          .toList();
      _progressErrorMsg = null;
      notifyListeners();
      return true;
    } else {
      _progressErrorMsg = response.errorMassage;
      notifyListeners();
      return false;
    }
  }
}
