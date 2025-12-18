import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';
import '../providers/verify_otp_screen_forget_password_provider.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  String? _email;
  String _otp = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _email = args['email'];
  }

  @override
  Widget build(BuildContext context) {
    final txtThemeData = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text('OTP Verification', style: txtThemeData.titleLarge),
              Text(
                _email == null
                    ? "Enter the 6-digit OTP sent to your email"
                    : 'A 6 digits verification OTP will be sent to your $_email',
                style: txtThemeData.labelMedium,
              ),
              SizedBox(height: 8),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                appContext: context,
                onChanged: (value){
                  _otp = value;
                },
                onCompleted: (value){
                  _otp = value;
                  if (kDebugMode) {
                    print('Oto Entered: $_otp');
                  }
                },
              ),
              SizedBox(height: 8),
              Consumer<VerifyOtpScreenForgetPasswordProvider>(
                builder: (context,verifyOtpProvider,child) {
                  return Visibility(
                    visible: verifyOtpProvider.otpSentProgressTask == false,
                    replacement: Center(child: CenteredCircularProgress()),
                    child: FilledButton(
                      onPressed: _onVerifyOtp,
                      child: Text('Verify'),
                    ),
                  );
                }
              ),
              SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Have account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: TextStyle(color: Colors.blue),
                            recognizer:
                                TapGestureRecognizer() // TapGestureRecognizer Clickable Widgte
                                  ..onTap = _onSignInPage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //login Button
  Future<void> _onVerifyOtp() async {
    if (_email == null || _email!.isEmpty) {
      showSnackBarMessage(context, 'Email Not Found, Please try again');
      return;
    }

    if (_otp.length < 6) {
      showSnackBarMessage(context, 'Please enter valid 6 digit OTP');
      return;
    }
    print('Verifying OTP: $_otp for email: $_email');

    final verifyOtpProvider = Provider.of<VerifyOtpScreenForgetPasswordProvider>(context,listen: false);
    final bool success = await verifyOtpProvider.onVerifyOtp(_email!, _otp);
    if(!mounted) return;

    if(success){
      showSnackBarMessage(context, 'OTP verified successfully');
      Navigator.pushNamed(context, '/reset',arguments: {'email':_email,'otp':_otp,});
    }else{
      showSnackBarMessage(context, verifyOtpProvider.otpErrMassege ?? 'Failed to verify OTP, Please try again');
    }
  }

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
