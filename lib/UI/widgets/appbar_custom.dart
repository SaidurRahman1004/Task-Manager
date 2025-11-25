import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/controllers/auth_controller.dart';
import 'package:task_manager_app/UI/screens/sign_in_screen.dart';
import 'package:task_manager_app/UI/screens/update_profile_screen.dart';

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
              backgroundImage: NetworkImage("https://i.postimg.cc/K4hb3sYj/photo-6089341595493797355-y.jpg",),
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
