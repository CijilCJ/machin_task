import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/course_model.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'courses';

  /// 🔹 Add Course (Admin)
  Future<void> addCourse(CourseModel course) async {
    await _firestore.collection(_collection).add(course.toMap());
  }

  /// 🔹 Get All Courses
  Future<List<CourseModel>> getAllCourses() async {
    final snapshot = await _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CourseModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// 🔹 Get Free Courses Only
  Future<List<CourseModel>> getFreeCourses() async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('isFree', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => CourseModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// 🔹 Get Course By ID
  Future<CourseModel?> getCourseById(String courseId) async {
    final doc =
        await _firestore.collection(_collection).doc(courseId).get();

    if (!doc.exists) return null;

    return CourseModel.fromMap(doc.data()!, doc.id);
  }

  /// 🔹 Update Course (Admin)
  Future<void> updateCourse(String courseId, CourseModel course) async {
    await _firestore
        .collection(_collection)
        .doc(courseId)
        .update(course.toMap());
  }

  /// 🔹 Delete Course (Admin)
  Future<void> deleteCourse(String courseId) async {
    await _firestore.collection(_collection).doc(courseId).delete();
  }
}
