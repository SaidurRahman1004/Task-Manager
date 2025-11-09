import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

import '../utils/asset_paths.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
                'Update Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildPhotosButton(),
                    SizedBox(width: 8),
                   // Expanded(child: TextFormField(decoration: InputDecoration(hintText: 'No file chosen')))
                    SizedBox(width: 8),
                   _buildPhotoInputField(),
                  ],
                ),
              ),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              TextFormField(
                decoration: InputDecoration(hintText: 'First name'),
              ),
              TextFormField(decoration: InputDecoration(hintText: 'Last name')),
              TextFormField(
                decoration: InputDecoration(hintText: 'Mobile'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(decoration: InputDecoration(hintText: 'Password')),
              SizedBox(height: 8),
              FilledButton(
                onPressed: () {},
                child: Icon(Icons.arrow_circle_right_outlined),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  //ImageButton
  Widget _buildPhotosButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Photos', style: TextStyle(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
    );
  }

  //PhotoInputFeild
  Widget _buildPhotoInputField() {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey, width: 0.5),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'No file chosen',
                style: TextStyle(color: Colors.grey, fontSize: 14),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
