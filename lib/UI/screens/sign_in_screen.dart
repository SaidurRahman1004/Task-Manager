import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';

import '../utils/asset_paths.dart';
import 'main_bottom_bav_holder_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // Enable real-time validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Get Started With',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _emailTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      } else if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _onSignIn,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onForgotPassword,
                          child: Text('Forgot Password?'),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(color: Colors.blue),
                                recognizer:
                                    TapGestureRecognizer() // TapGestureRecognizer Clickable Widgte
                                      ..onTap = _onSignUpPage,
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
  void _onSignIn() {
    //Navigator.pushNamed(context, '/mainNav');
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  //sign in method
  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text.trim(),
    };
    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.loginEndpoint,
      body: requestBody,
    );
    //updating ui
    _signInProgress = false;
    setState(() {});

    ///handling response
    if (response.isSuccess) {
      //save user data if available
      if (response.body != null && response.body['data'] != null) {
        UserModel userModel = UserModel.fromJson(response.body['data']);
        String accessToken = response.body['token'] ?? '';
        await AuthController.saveUserData(accessToken, userModel);
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/mainNav');
        }
      }else{
        showSnackBarMessage(context, 'Invalid response format.');
      }
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  //forgot password
  void _onForgotPassword() {
    Navigator.pushNamed(context, '/forgetPass');
  }

  void _onSignUpPage() {
    Navigator.pushNamed(context, '/signup');
  }
}
