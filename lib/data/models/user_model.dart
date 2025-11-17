class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'],
      email: jsonData['email'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      mobile: jsonData['mobile'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
    };
  }
}
