import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../controllers/auth_controller.dart';

class UpdateProfileProvider extends ChangeNotifier {
  bool _updateProfileInProgress = false;
  String? _updateProfileErrorMsg;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;



  bool get updateProfileInProgress => _updateProfileInProgress;

  String? get updateProfileErrorMsg => _updateProfileErrorMsg;
  XFile? get pickedImage => _pickedImage;

  Future<bool> updateProfile(
      String email,
      String firstName,
      String lastName,
      String mobile,
      String? password,
      ) async {
    _updateProfileInProgress = true;
    notifyListeners();

    //Create Request Body
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }

    if (_pickedImage != null) {
      Uint8List imageBytes = await _pickedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    final NetworkResponse response = await Networkcaller.postRequest(
      Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;


    if(response.isSuccess){
      UserModel updatedUser = UserModel.fromJson(response.body['data']);
      await AuthController.updateUserData(updatedUser);
      _updateProfileErrorMsg = null;
      notifyListeners();
      return true;
    }else{
      _updateProfileErrorMsg = response.errorMassage;
      notifyListeners();
      return false;
    }
  }

  //Update Image
  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      _pickedImage = image;
      notifyListeners();

    } else {
      print('No image selected.');
    }
  }
}
