import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/UI/screens/sign_in_screen.dart';
import 'package:task_manager_app/UI/screens/sign_up_screen.dart';
import 'package:task_manager_app/UI/utils/asset_paths.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.logo,
            width: 250, // 40% of screen width
          ),
        ),
      ),
    );
  }
}
