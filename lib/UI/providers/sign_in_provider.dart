import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../controllers/auth_controller.dart';


class SignInProvider extends ChangeNotifier{
   bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMassege => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };
    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.loginEndpoint,
      body: requestBody,
    );
    //updating ui
    _isLoading = false;
    notifyListeners();


    ///handling response
    if (response.isSuccess) {
      //save user data if available
      if (response.body != null && response.body['data'] != null) {
        UserModel userModel = UserModel.fromJson(response.body['data']);
        String accessToken = response.body['token'] ?? '';
        await AuthController.saveUserData(accessToken, userModel);
        _errorMessage = null;
        isSuccess = true;
      }
    } else {
      _errorMessage = response.errorMassage;

    }
    return isSuccess;
  }


}