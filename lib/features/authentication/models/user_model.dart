class UserModel {
  String? id;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // Convert UserModel to a Map to save in Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  // Convert Firestore document to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
