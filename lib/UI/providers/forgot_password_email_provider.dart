import 'package:flutter/cupertino.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class ForgotPasswordEmailProvider extends ChangeNotifier {
  bool _getForgotPasswordInProgress = false;
  String? _forgotPasswordErrorMsg;

  bool get getForgotPasswordInProgress => _getForgotPasswordInProgress;

  String? get forgotPasswordErrorMsg => _forgotPasswordErrorMsg;

  Future<bool> onSentOtp(String email) async {
    _getForgotPasswordInProgress = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.recoverVerifyEmailUrl(email),
    );

    _getForgotPasswordInProgress = false;

    if (response.isSuccess) {
      _forgotPasswordErrorMsg = null;
      notifyListeners();
      return true;
    } else {
      _forgotPasswordErrorMsg = response.errorMassage;
      notifyListeners();
      return false;

    }
  }
}
