import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String profileImage;

  // Optional / Future-ready fields
  final List<String> enrolledCourses;
  final Map<String, double> courseProgress;
  final Timestamp createdAt;

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.enrolledCourses,
    required this.courseProgress,
    required this.createdAt,
  });

  // Convert Firestore → Model
  factory StudentModel.fromMap(Map<String, dynamic> map, String uid) {
    return StudentModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'student',
      profileImage: map['profileImage'] ?? '',
      enrolledCourses: List<String>.from(map['enrolledCourses'] ?? []),
      courseProgress: Map<String, double>.from(map['courseProgress'] ?? {}),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  // Convert Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'enrolledCourses': enrolledCourses,
      'courseProgress': courseProgress,
      'createdAt': createdAt,
    };
  }
}











// class StudentsModel {
//   String studentId;
//   String adminId;
//   String teacherId;
//   String stdClass;
//   String name;
//   String email;
//   String parentName;
//   String phone;
//   String profileImage;
//   String rollNo;
//   DateTime dateOfBirth;
//   DateTime admissionDate;

//   StudentsModel({
//     required  this.studentId,
//     required this.adminId,
//     required this.teacherId,
//     required this.stdClass,
//     required this.name,
//     required this.email,
//     required this.parentName,
//     required this.phone,
//     required this.profileImage,
//     required this.rollNo,
//     required this.dateOfBirth,
//     required this.admissionDate
//   });

//   factory StudentsModel.fromjson(Map<String,dynamic>json){
//     return StudentsModel(
//       studentId: json["studentId"], 
//       adminId: json["adminId"], 
//       teacherId: json["teacherId"], 
//       stdClass: json["stdClass"], 
//       name: json["name"], 
//       email: json["email"], 
//       parentName: json["parentName"], 
//       phone: json["phone"], 
//       profileImage: json["profileImage"], 
//       rollNo: json["rollNo"], 
//       dateOfBirth: json["dateOfBirth"], 
//       admissionDate: json["admissionDate"]);
//   }

//   Map<String,dynamic>toJson(){
//     return{
//       "studentId":studentId,
//       "adminId":adminId,
//       "teacherId":teacherId,
//       "stdClass":stdClass,
//       "name":name,
//       "email":email,
//       "parentName":parentName,
//       "phone":phone,
//       "profileImage":profileImage,
//       "rollNo":rollNo,
//       "dateOfBirth":dateOfBirth,
//       "admissionDate":admissionDate
//     };
//   }

// }