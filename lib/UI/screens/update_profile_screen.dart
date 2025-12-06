import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';
import 'package:task_manager_app/UI/widgets/circular_progress.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';

import '../../data/utils/urls.dart';
import '../utils/asset_paths.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _PickedImage;
  bool _updateProfileInProgress = false;

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
                  PhotoPickerWidget(onPressed: () {
                     _pickImage();
                  }),

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
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredCircularProgress(),
                    child: FilledButton(
                      onPressed: onUpdateProfile,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
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

  //Picked Image function
  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _PickedImage = image;
      });
    } else {
      print('No image selected.');
    }
  }

  //Update Profile Functions
  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    //Create Request Body
    Map<String, dynamic> requestBody = {
      "email": _emailController.text,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }

    if (_PickedImage != null) {
      Uint8List imageBytes = await _PickedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    setState(() {});

    if(response.isSuccess){
      requestBody['_id'] = AuthController.user!.id;
      await AuthController.updateUserData(UserModel.fromJson(requestBody));
      showSnackBarMessage(context, 'Profile updated successfully');
    }else{
      showSnackBarMessage(context, response.errorMassage);
    }
  }
}
