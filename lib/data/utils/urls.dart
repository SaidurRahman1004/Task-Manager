class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registerEndpoint = '$_baseUrl/Registration';
  static const String loginEndpoint = '$_baseUrl/Login';
  static const String createNewTaskUrl = '$_baseUrl/createTask';
  static const String newTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String progressTasksUrl = '$_baseUrl/listTaskByStatus/Progress';
  static const String cancleTasksUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String completedTasksUrl =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String takCountUrl = '$_baseUrl/taskStatusCount';

  // Function to generate URL for changing task status
  static String changeTaskStatusUrl(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  // Function to generate URL for deleting a task by ID
  static String deleteTaskById(String taskId) => '$_baseUrl/deleteTask/$taskId';
}
