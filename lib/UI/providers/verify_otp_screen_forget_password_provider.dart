import 'package:flutter/cupertino.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class VerifyOtpScreenForgetPasswordProvider extends ChangeNotifier {
  bool _otpSentProgressTask = false;
  String? _otpErrMassege;
  bool get otpSentProgressTask => _otpSentProgressTask;
  String? get otpErrMassege => _otpErrMassege;


  Future<bool> onVerifyOtp(String email, String otp) async {


    _otpSentProgressTask = true;
    notifyListeners();

    final NetworkResponse response = await Networkcaller.getRequest(
        Urls.recoverVerifyOtpUrl(email, otp)
    );
    _otpSentProgressTask = false;

    if(response.isSuccess){
      _otpErrMassege = null;
      notifyListeners();
      return true;

    }else{
      _otpErrMassege = response.errorMassage;
      notifyListeners();
      return false;
    }
  }
}