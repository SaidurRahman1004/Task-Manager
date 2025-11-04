import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

import '../utils/asset_paths.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Get Started With',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8,),
                TextFormField(decoration: InputDecoration(hintText: 'Email'),),
                TextFormField(decoration: InputDecoration(hintText: 'Password'),),
                SizedBox(height: 8,),
                FilledButton(onPressed: _onSignIn, child: Icon(Icons.arrow_circle_right_outlined),),
                SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [
                      TextButton(onPressed: _onForgotPassword, child: Text('Forgot Password?'),),
                      RichText(
                        text:  TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()     // TapGestureRecognizer Clickable Widgte
                                ..onTap = _onSignUpPage,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )



              ]
          ),
        ),
      ),
    );
  }
//login Button
  void _onSignIn() {
  }
//forgot password
  void _onForgotPassword() {
  }

  void _onSignUpPage() {
    Navigator.pushNamed(context, '/signup');
  }
}



