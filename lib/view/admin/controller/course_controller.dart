import 'package:flutter/material.dart';
import '../model/course_model.dart';
import '../service/course_service.dart';

class CourseController extends ChangeNotifier {
  final CourseService _courseService = CourseService();

  /// State
  List<CourseModel> courses = [];
  bool isLoading = false;
  String errorMessage = '';

  /// 🔹 Get All Courses
  Future<void> fetchAllCourses() async {
    try {
      isLoading = true;
      notifyListeners();

      courses = await _courseService.getAllCourses();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Get Free Courses
  Future<void> fetchFreeCourses() async {
    try {
      isLoading = true;
      notifyListeners();

      courses = await _courseService.getFreeCourses();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Add Course (Admin)
  Future<void> addCourse(CourseModel course) async {
    try {
      isLoading = true;
      notifyListeners();

      await _courseService.addCourse(course);
      await fetchAllCourses();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Update Course (Admin)
  Future<void> updateCourse(
      String courseId, CourseModel course) async {
    try {
      isLoading = true;
      notifyListeners();

      await _courseService.updateCourse(courseId, course);
      await fetchAllCourses();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Delete Course (Admin)
  Future<void> deleteCourse(String courseId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _courseService.deleteCourse(courseId);
      await fetchAllCourses();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}










// import 'package:flutter/material.dart';
// import 'package:machin_task/view/admin/model/course_model.dart';
// import 'package:machin_task/view/admin/service/course_service.dart';
// import 'package:machin_task/widget/common.dart';

// class CourseController extends ChangeNotifier {
//   CourseService courseService = CourseService();

//   final titleCntrl = TextEditingController();
//   final descriptionCntrl = TextEditingController();
//   final thumbnailCntrl = TextEditingController();

//   Future<String?> courseAdd({
//     BuildContext? context,
//     CourseModel? course,
//   }) async {
//     final course = await courseService.addCouser(
//       title: titleCntrl.text.trim(),
//       description: descriptionCntrl.text.trim(),
//       thumbnail: thumbnailCntrl.text.trim(),
//     );
//     if (context!.mounted) {
//       if (course == "succes") {
//         showSnackBarMessage(context, "Course Add Successfully");
//       } else {
//         showSnackBarMessage(context, course.toString());
//       }
//     }
//   }
//   void dispose() {
//     titleCntrl.dispose();
//     descriptionCntrl.dispose();
//     thumbnailCntrl.dispose();
//     titleCntrl.clear();
//     descriptionCntrl.clear();
//     thumbnailCntrl.clear();
//   }
// }
