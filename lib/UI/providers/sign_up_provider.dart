import 'package:flutter/cupertino.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpProvider extends ChangeNotifier {
  bool _signUpInProgress = false;
  String? _errorMessage;

  bool get signUpInProgress => _signUpInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    _signUpInProgress = true;
    notifyListeners();


    Map<String, String> requestBody = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password,
    };
    NetworkResponse response = await Networkcaller.postRequest(
      Urls.registerEndpoint,
      body: requestBody,
    );
    _signUpInProgress = false;

    if (response.isSuccess) {
      _errorMessage = null;
      notifyListeners();
      return true;

    } else {
      _errorMessage = response.errorMassage;
      notifyListeners();
    }
    return false;
  }
}
