import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'dart:convert';

class TaskManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key,  this.fromUpdateProfile = false});
  final bool fromUpdateProfile;

  @override
  State<TaskManagerAppBar> createState() => _TaskManagerAppBarState();

  @override

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TaskManagerAppBarState extends State<TaskManagerAppBar> {
  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/updateProfile').then((_){
            if(mounted){
              setState(() {});
            }
          });
        },
        child: Row(
          spacing: 12,
          children: [
            CircleAvatar(
              backgroundImage: _getImageProvidr(),
              child: _getImageProvidr() == null ? Icon(Icons.person) : null,
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

  ImageProvider ? _getImageProvidr(){
    final String? photo = AuthController.user?.photo;
    if(photo != null && photo.isNotEmpty){
      try{
        return MemoryImage(base64Decode(photo));

      }catch(e){
        return null;

      }
    }
    return null;
  }



  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
