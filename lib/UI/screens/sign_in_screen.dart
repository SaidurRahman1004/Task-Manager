import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';
import '../../UI/providers/sign_in_provider.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _signInProvider = SignInProvider();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _signInProvider,
      child: Scaffold(
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
                    Consumer<SignInProvider>(
                      builder: (BuildContext context, SignInProvider , child) {
                        return Visibility(
                          visible: SignInProvider.isLoading == false,
                          replacement: Center(child: CircularProgressIndicator()),
                          child: FilledButton(
                            onPressed: _onSignIn,
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },

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

    final bool isSuccess = await _signInProvider.signIn(
        _emailTEController.text.trim(),
        _passwordTEController.text.trim(),
    );

   // final errorMsgProvider = _signInProvider.errorMassege!;

    ///handling response
    if (isSuccess) {
      if(mounted){
        Navigator.pushReplacementNamed(context, '/mainNav');
      }

      }else{
        final errorMsgProvider = _signInProvider.errorMassege;
        showSnackBarMessage(context, errorMsgProvider!);
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

