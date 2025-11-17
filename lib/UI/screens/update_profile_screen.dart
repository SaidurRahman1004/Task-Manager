import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/background_screen.dart';

import '../utils/asset_paths.dart';
import '../widgets/photo_picker.dart';

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
              PhotoPickerWidget(onPressed: () {}),

              ///import '../widgets/photo_picker.dart';
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
}
