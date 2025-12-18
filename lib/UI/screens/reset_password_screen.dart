import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import '../providers/reset_password_provider.dart';
import '../widgets/circular_progress.dart';
import '../widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? _email;
  String? _otp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _email = args['email'];
    _otp = args['otp'];
  }

  @override
  Widget build(BuildContext context) {
    final txtThemeData = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _globalKey,
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
                TextFormField(
                  decoration: InputDecoration(hintText: 'New Password'),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Consumer<ResetPasswordProvider>(
                  builder: (context, resetProvider, child) {
                    return Visibility(
                      visible: resetProvider.inResetProgress == false,
                      replacement: Center(child: CenteredCircularProgress()),
                      child: FilledButton(
                        onPressed: _onOrpVerify,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  },
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
    );
  }

  //login Button
  Future<void> _onOrpVerify() async {
    if (_email == null || _otp == null) {
      showSnackBarMessage(context, 'Email or OTP not found, please try again');
      return;
    }
    if (_globalKey.currentState?.validate() != true) {
      return;
    }
    final resetPasswordProvider = Provider.of<ResetPasswordProvider>(
      context,
      listen: false,
    );
    final bool successed = await resetPasswordProvider.onOrpVerify(
      _email!,
      _otp!,
      _passwordController.text,
    );
    if (!mounted) return;

    if (successed) {
      showSnackBarMessage(
        context,
        'Password reset successfully. Please sign in with your new password.',
      );
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      showSnackBarMessage(
        context,
        resetPasswordProvider.resetErrorMsg ??
            'Failed to reset password, please try again',
      );
    }
  }

  //forgot password

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }
}
