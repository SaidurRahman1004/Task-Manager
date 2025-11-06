import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import '../../app.dart';

import '../utils/asset_paths.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
              Text('Reset Password', style: txtThemeData.titleLarge),
              Text(
                'Minimum length of password should more than 8 letters',
                style: txtThemeData.labelMedium,
              ),
              SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'New Password')),
              TextFormField(decoration: InputDecoration(hintText: 'Confirm Password')),
              SizedBox(height: 8),
              FilledButton(
                onPressed: _onSignIn,
                child: Icon(Icons.arrow_circle_right_outlined),
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
