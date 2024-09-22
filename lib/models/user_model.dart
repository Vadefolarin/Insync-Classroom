import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String profilePictureUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePictureUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'student',
      profilePictureUrl: data['profilePictureUrl'] ??
          'https://www.w3schools.com/howto/img_avatar.png', // Default avatar
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
