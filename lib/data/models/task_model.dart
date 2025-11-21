class TaskCountModel {
  final String id;
  final int sum;

  TaskCountModel({required this.id, required this.sum});

  factory TaskCountModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskCountModel(id: jsonData['id'], sum: jsonData['sum']);
  }
}
