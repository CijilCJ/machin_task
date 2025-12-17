import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String profileImage;

  // Admin-specific fields
  final List<String> createdCourses;
  final Timestamp createdAt;

  AdminModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.createdCourses,
    required this.createdAt,
  });

  // Firestore → Model
  factory AdminModel.fromMap(Map<String, dynamic> map, String uid) {
    return AdminModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'admin',
      profileImage: map['profileImage'] ?? '',
      createdCourses: List<String>.from(map['createdCourses'] ?? []),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  // Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'createdCourses': createdCourses,
      'createdAt': createdAt,
    };
  }
}









// class AdminModel {
//   String adminId;
//   String name;
//   String email;
//   String phoneNumber;
//   String schoolName;

//   AdminModel({
//     required this.adminId,
//     required this.email,
//     required this.name,
//     required this.phoneNumber,
//     required this.schoolName
//   });

//   factory AdminModel.fromjson(Map<String,dynamic>json){
//     return AdminModel(
//       adminId: json["adminId"], 
//       email: json["email"], 
//       name: json["name"], 
//       phoneNumber: json["phoneNumber"], 
//       schoolName: json["schoolName"]
//     );
//   }

//   Map<String,dynamic>toJson(){
//     return {
//       "adminId":adminId,
//       "email":email,
//       "name":name,
//       "phoneNumber":phoneNumber,
//       "schoolName":schoolName,
//     };
//   }
// }