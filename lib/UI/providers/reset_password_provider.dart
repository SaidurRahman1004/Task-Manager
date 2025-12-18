import 'package:flutter/cupertino.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _inResetProgress = false;
  String? _resetErrorMsg;

  bool get inResetProgress => _inResetProgress;

  String? get resetErrorMsg => _resetErrorMsg;

  Future<bool> onOrpVerify(String email, String otp, String password) async {
    _inResetProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.recoverResetPasswordUrl,
      body: {'email': email, 'otp': otp, 'password': password},
    );

    _inResetProgress = false;

    if (response.isSuccess) {
      _resetErrorMsg = null;
      notifyListeners();
      return true;
    } else {
      _resetErrorMsg = response.errorMassage;
      notifyListeners();
      return false;
    }
  }
}
