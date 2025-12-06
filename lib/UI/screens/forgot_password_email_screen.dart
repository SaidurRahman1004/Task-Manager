import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import '../../app.dart';

import '../../data/utils/urls.dart';
import '../utils/asset_paths.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgressLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtThemeData = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('Your Email Address', style: txtThemeData.titleLarge),
                  Text(
                    'A 6 digits verification OTP will be sent to your email address',
                    style: txtThemeData.labelMedium,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      final emailReg = RegExp(r'^[\w\.\-]+@[\w\.\-]+\.\w{2,}$');
                      if (!emailReg.hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Visibility(
                      visible: _inProgressLoading == false,
                      replacement: CenteredCircularProgress(),
                      child: FilledButton(
                        onPressed: _onSentOtp,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
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
        ),
      ),
    );
  }

  //login Button
  Future<void> _onSentOtp() async {
    if (!_formkey.currentState!.validate()) return;
    final email = _emailcontroller.text.trim();

    setState(() {
      _inProgressLoading = true;
    });

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.recoverVerifyEmailUrl(email),
    );

    setState(() {
      _inProgressLoading = false;
    });

    if(response.isSuccess){
      showSnackBarMessage(context, 'OTP sent successfully');
      Navigator.pushNamed(context, '/otp', arguments: {'email': email});
    }else{
      showSnackBarMessage(context, response.errorMassage ?? 'Failed to send OTP');
    }
  }

  //forgot password

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
