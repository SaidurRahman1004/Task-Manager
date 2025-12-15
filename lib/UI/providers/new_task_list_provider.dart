import 'package:flutter/cupertino.dart';
import '../../data/models/task_count_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  List<TaskModel> _newTaskList = [];
  bool _listInProgress = false;
  String? _listErrorMessage;

  List<TaskModel> get newTaskList => _newTaskList;

  bool get listInProgress => _listInProgress;

  String? get listErrorMessage => _listErrorMessage;

  // State variables for the task count
  List<TaskCountModel> _taskCountList = [];
  bool _countInProgress = false;
  String? _countErrorMessage;

  List<TaskCountModel> get taskCountList => _taskCountList;

  bool get countInProgress => _countInProgress;

  String? get countErrorMessage => _countErrorMessage;


  Future<bool> getNewTaskList() async {
    _listInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.newTaskUrl,
    );
    _listInProgress = false;

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      _listErrorMessage = null;
      notifyListeners();
      return true;
    } else {
      _listErrorMessage = response.errorMassage;
      notifyListeners();
      return false;
    }
  }

  //task Count
  Future<bool> getTaskCountList() async {
    _countInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.takCountUrl,
    );
    _countInProgress = false;

    if (response.isSuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _taskCountList = list;
      _countErrorMessage = null;
      notifyListeners();
      return true;

    } else {
      _countErrorMessage = response.errorMassage;
      notifyListeners();
      return  false;
    }


  }
}
