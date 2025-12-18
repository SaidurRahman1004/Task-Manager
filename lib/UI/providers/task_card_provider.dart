import 'package:flutter/cupertino.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskCardProvider extends ChangeNotifier{

  bool _changeStatusInProgress = false;
  bool _deleteInProgress = false;

  String? _errorMessage;

  bool get changeStatusInProgress => _changeStatusInProgress;
  bool get deleteInProgress => _deleteInProgress;
  String? get errorMessage => _errorMessage;

  // Change the status of the task
  Future<bool> chngeStatus(String taskId,String status) async {
    _changeStatusInProgress = true;
    notifyListeners();
    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.changeTaskStatusUrl(taskId, status),
    );
    _changeStatusInProgress = false;
    if (response.isSuccess) {
      _errorMessage =null;
      notifyListeners();
      return true;

    } else {
      _errorMessage = response.errorMassage;
      notifyListeners();
      return false;
    }
  }

  //Delet Task Functions
  Future<bool> deleteTask(String taskId) async {
    _deleteInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.deleteTaskById(taskId),
    );
    _deleteInProgress = false;
    if (response.isSuccess) {
      _errorMessage =null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.errorMassage;
      notifyListeners();
      return false;


    }
  }

}