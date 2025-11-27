import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:task_manager_app/UI/widgets/snack_bar_message.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState extends State<ForgotPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _verifyOtpInProgress = false;
  String? _email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get email from navigation arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      _email = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtThemeData = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('OTP Verification', style: txtThemeData.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification OTP has been sent to your email address',
                  style: txtThemeData.labelMedium,
                ),
                const SizedBox(height: 16),
                PinCodeTextField(
                  controller: _otpTEController,
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
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  appContext: context,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !_verifyOtpInProgress,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                    onPressed: _onVerifyOtp,
                    child: const Text('Verify'),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Have account?',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
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

  void _onVerifyOtp() {
    final String otp = _otpTEController.text.trim();
    if (otp.length != 6) {
      showSnackBarMessage(context, 'Please enter a valid 6-digit OTP');
      return;
    }
    if (_email == null || _email!.isEmpty) {
      showSnackBarMessage(context, 'Email not found. Please try again.');
      return;
    }
    _verifyOtpApi(otp);
  }

  Future<void> _verifyOtpApi(String otp) async {
    _verifyOtpInProgress = true;
    setState(() {});

    final NetworkResponse response = await Networkcaller.getRequest(
      Urls.verifyOtpUrl(_email!, otp),
    );

    _verifyOtpInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'OTP verified successfully');
        Navigator.pushNamed(
          context,
          '/reset',
          arguments: {'email': _email, 'otp': otp},
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
  }

  void _onSignInPage() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
