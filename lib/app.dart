import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/screens/splash_screen.dart';
import 'UI/providers/add_new_task_provider.dart';
import 'UI/providers/cancelled_taskList_providers.dart';
import 'UI/providers/completed_task_list_provider.dart';
import 'UI/providers/forgot_password_email_provider.dart';
import 'UI/providers/new_task_list_provider.dart';
import 'UI/providers/progress_task_list_provider.dart';
import 'UI/providers/reset_password_provider.dart';
import 'UI/providers/task_card_provider.dart';
import 'UI/providers/update_profile_provider.dart';
import 'UI/providers/verify_otp_screen_forget_password_provider.dart';
import 'UI/screens/add_new_task_screen.dart';
import 'UI/screens/forgot_password_email_screen.dart';
import 'UI/screens/main_bottom_bav_holder_screen.dart';
import 'UI/screens/reset_password_screen.dart';
import 'UI/screens/sign_in_screen.dart';
import 'UI/screens/sign_up_screen.dart';
import 'UI/screens/update_profile_screen.dart';
import 'UI/screens/verify_otp_screen_forget_password.dart';

class TaskManegerApp extends StatelessWidget {
  const TaskManegerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_)=> SignInProvider())
        ChangeNotifierProvider(create: (_)=> AddNewTaskProvider()),
        ChangeNotifierProvider(create: (_)=> CancleTaskProvider()),
        ChangeNotifierProvider(create: (_)=> CompletedTaskListProvider()),
        ChangeNotifierProvider(create: (_)=> ForgotPasswordEmailProvider()),
        ChangeNotifierProvider(create: (_)=> ProgressTaskListProvider()),
        ChangeNotifierProvider(create: (_)=> ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_)=> UpdateProfileProvider()),
        ChangeNotifierProvider(create: (_)=> NewTaskListProvider()),
        ChangeNotifierProvider(create: (_)=> VerifyOtpScreenForgetPasswordProvider()),
        ChangeNotifierProvider(create: (_)=> TaskCardProvider()),

      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Task Manager App',
        //Routs
        routes: {
          '/login' : (_) => const SignInScreen(),
          '/signup' : (_) => const SignUpScreen(),
          '/forgetPass' : (_) => const ForgotPasswordEmailScreen(),
          '/reset': (_) => const ResetPasswordScreen(),
          '/otp': (_) => const ForgotPasswordVerifyOtpScreen(),
          '/mainNav': (_) => const MainBottomNavHolderScreen(),
          '/newTask': (_) => const AddNewTaskScreen(),
          '/updateProfile' : (_) => UpdateProfileScreen(),
        },
        //themeing
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,

            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,

            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),


          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),

            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
              labelMedium: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey,
              ),
          ),
          scaffoldBackgroundColor: Colors.green.shade50,

        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}


///////////////////
