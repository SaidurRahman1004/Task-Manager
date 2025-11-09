import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/screens/tasksPages/cancelled_task_list_screen.dart';
import 'package:task_manager_app/UI/screens/tasksPages/completed_task_list_screen.dart';
import 'package:task_manager_app/UI/screens/tasksPages/new_task_list_screen.dart';
import 'package:task_manager_app/UI/screens/tasksPages/progress_task_list_screen.dart';

import '../widgets/appbar_custom.dart';

class MainBottomNavHolderScreen extends StatefulWidget {
  const MainBottomNavHolderScreen({super.key});

  @override
  State<MainBottomNavHolderScreen> createState() =>
      _MainBottomNavHolderScreenState();
}

class _MainBottomNavHolderScreenState extends State<MainBottomNavHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CancelledTaskListScreen(),
    CompletedTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time),
            label: 'Process',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.done),
            label: 'Complete',
          ),
        ],
      ),
    );
  }
}
