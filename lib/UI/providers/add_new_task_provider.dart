import 'package:flutter/cupertino.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class AddNewTaskProvider extends ChangeNotifier {
  bool _addNewTaskInProgress = false;
  String? _addNewTaskErrorMsg;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  String? get addNewTaskErrorMsg => _addNewTaskErrorMsg;

  Future<bool> addNewTask(
    String title,
    String description,
    String status,
  ) async {
    _addNewTaskInProgress = true;
    notifyListeners();

    //Create Request Body

    Map<String, dynamic> rewuestbody = {
      'title': title,
      'description': description,
      'status': status,
    };

    //Call API

    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.createNewTaskUrl,
      body: rewuestbody,
    );
    _addNewTaskInProgress = false;

    if (response.isSuccess) {
      _addNewTaskErrorMsg = null;
      notifyListeners();
      return true;
    } else {
      _addNewTaskErrorMsg = response.errorMassage;
      notifyListeners();
      return false;
    }
  }
}
