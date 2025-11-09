import 'package:flutter/material.dart';
import 'package:task_manager_app/UI/widgets/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(),
            _buildTaskSummaryListView(),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (_, index) {
                return TaskCard();
              },
              separatorBuilder: (_, index) {
                return SizedBox(height: 8);
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, '/newTask');
  }

  //Sumury Card
  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Card(
            elevation: 0,
            color: Colors.white,
              margin: EdgeInsets.only(left: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                children: [
                  Text('12', style: TextTheme.of(context).titleMedium),
                  Text('New', style: TextTheme.of(context).labelSmall),
                ],
              ),

            )

          );
        },
      ),
    );
  }
}
