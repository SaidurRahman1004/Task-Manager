import 'package:flutter/material.dart';

class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key});

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
                Text("Saidur Rahman",style: txtStyle.bodyLarge?.copyWith(
                  color: Colors.white,
                ),),
                Text("saidurrahman1004@gmail.com",style: txtStyle.bodySmall?.copyWith(
                  color: Colors.white,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
