import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import '../providers/update_profile_provider.dart';
import '../widgets/photo_picker.dart';
import '../widgets/snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final UserModel userModel = AuthController.user!;
    _emailController.text = userModel.email;
    _firstNameController.text = userModel.firstName;
    _lastNameController.text = userModel.lastName;
    _mobileController.text = userModel.mobile;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Consumer<UpdateProfileProvider>(
                    builder: (context, updateProvider, child) {
                      return PhotoPickerWidget(
                        PickedImage: updateProvider.pickedImage,
                        onPressed: () {
                          updateProvider.pickImage();
                        },
                      );
                    },
                  ),

                  ///import '../widgets/photo_picker.dart';
                  TextFormField(
                    enabled: false,
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First name'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: 'Last name'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    controller: _mobileController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isNotEmpty && value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 8),
                  Consumer<UpdateProfileProvider>(
                    builder: (context, updateProvider, child) {
                      return Visibility(
                        visible:
                            updateProvider.updateProfileInProgress == false,
                        replacement: CenteredCircularProgress(),
                        child: FilledButton(
                          onPressed: onUpdateProfile,
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //update profile function
  void onUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    final updateProfileProvider = Provider.of<UpdateProfileProvider>(
      context,
      listen: false,
    );
    final bool seccceed = await updateProfileProvider.updateProfile(
      _emailController.text.trim(),
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _mobileController.text.trim(),
      _passwordController.text,
    );
    if (!mounted) return;

    if (seccceed) {
      showSnackBarMessage(context, 'Profile updated successfully');
    } else {
      showSnackBarMessage(
        context,
        updateProfileProvider.updateProfileErrorMsg ??
            'Failed to update profile',
      );
    }
  }
}
