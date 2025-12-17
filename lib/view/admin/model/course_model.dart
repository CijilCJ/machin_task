import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;

  // Content
  final String videoUrl;
  final String pdfUrl;
  final String pptUrl;

  // MCQs
  final List<Map<String, dynamic>> mcqs;

  // Metadata
  final bool isFree;
  final Timestamp createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.pdfUrl,
    required this.pptUrl,
    required this.mcqs,
    required this.isFree,
    required this.createdAt,
  });

  // Firestore → Model
  factory CourseModel.fromMap(
      Map<String, dynamic> map, String id) {
    return CourseModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      pdfUrl: map['pdfUrl'] ?? '',
      pptUrl: map['pptUrl'] ?? '',
      mcqs: List<Map<String, dynamic>>.from(map['mcqs'] ?? []),
      isFree: map['isFree'] ?? true,
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  // Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'pdfUrl': pdfUrl,
      'pptUrl': pptUrl,
      'mcqs': mcqs,
      'isFree': isFree,
      'createdAt': createdAt,
    };
  }
}









// class CourseModel {
//   String courseId;
//   String title;
//   String description;
//   String thumbnail;

//   CourseModel({
//     required this.courseId,
//     required this.title,
//     required this.description,
//     required this.thumbnail,
//   });

//   factory CourseModel.fromjson(Map<String, dynamic> json) {
//     return CourseModel(
//       courseId: json["courseId"],
//       title: json["title"],
//       description: json["description"],
//       thumbnail: json["thumbnail"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "courseId": courseId,
//       "title": title,
//       "description": description,
//       "thumbnail": thumbnail,
//     };
//   }
// }
