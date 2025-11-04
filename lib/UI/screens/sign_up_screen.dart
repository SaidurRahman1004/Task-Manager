import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

import '../utils/asset_paths.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  'Join With Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8,),
                TextFormField(decoration: InputDecoration(hintText: 'Email'),),
                TextFormField(
                  decoration: InputDecoration(hintText: 'First name'),),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Last name'),),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),),
                SizedBox(height: 8,),
                FilledButton(onPressed: _onSignUp,
                  child: Icon(Icons.arrow_circle_right_outlined),),
                SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: ' Sign In',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer() // TapGestureRecognizer Clickable Widgte
                                ..onTap = _onSignInPage,
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


  void _onSignUp() {
  }

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
