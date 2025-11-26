import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'dart:convert';

class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key,  this.fromUpdateProfile = false});
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/updateProfile');
        },
        child: Row(
          spacing: 12,
          children: [
            CircleAvatar(
              child: AuthController.user!.photo.isEmpty ? Icon(Icons.person) : Image.memory(
                base64Decode(AuthController.user!.photo,),fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AuthController.user?.fullName ?? "",style: txtStyle.bodyLarge?.copyWith(
                  color: Colors.white,
                ),),
                Text(AuthController.user?.email ?? "",style: txtStyle.bodySmall?.copyWith(
                  color: Colors.white,
                ),),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: () async{
          await AuthController.clearUserData();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
              (predicate)=> false

          );
        }, icon: Icon(Icons.logout)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
