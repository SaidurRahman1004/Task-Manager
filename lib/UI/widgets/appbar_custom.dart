import 'package:flutter/material.dart';

class TaskManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManagerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 12,
        children: [
          CircleAvatar(),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
