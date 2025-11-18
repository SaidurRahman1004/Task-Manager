import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';
import 'package:email_validator/email_validator.dart';

import '../utils/asset_paths.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

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
                    'Join With Us',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailTEController,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'First name'),
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Last name'),
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },

                    decoration: InputDecoration(hintText: 'Mobile'),
                  ),

                  TextFormField(
                    controller: _passwordTEController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      } else if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },

                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _signUpInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _onSignUp,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
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

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      //Sign Up Functionality
      Future<void> _signUp() async {
        _signUpInProgress = true;
        setState(() {});
        Map<String, String> requestBody = {
          'email': _emailTEController.text.trim(),
          'first_name': _firstNameTEController.text.trim(),
          'last_name': _lastNameTEController.text.trim(),
          'mobile': _mobileTEController.text.trim(),
          'password': _passwordTEController.text.trim(),
        };
        NetworkResponse response = await Networkcaller.postRequest(
          Urls.registerEndpoint,
          body: requestBody,
        );
        _signUpInProgress = false;
        setState(() {

        });
        if(response.isSuuccess){
          _clearTextFields();
          showSnackBarMessage(context, 'Sign Up Successful! Please Log In.');
        }else{
          showSnackBarMessage(context, response.errorMassage);
        }
      }

    }
  }
  void _clearTextFields(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
