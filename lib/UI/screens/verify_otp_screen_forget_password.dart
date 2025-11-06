import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState extends State<ForgotPasswordVerifyOtpScreen> {
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
              Text('A 6 digits verification OTP will be sent to your email address', style: txtThemeData.labelMedium),
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
              ),
              SizedBox(height: 8),
              FilledButton(
                onPressed: _onSignIn,
                child: Text('Verify'),
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
  void _onSignIn() {}

  //forgot password
  void _onForgotPassword() {}

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
