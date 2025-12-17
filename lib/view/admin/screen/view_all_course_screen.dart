import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/model/course_model.dart';
import 'package:provider/provider.dart';


class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<CourseController>().fetchAllCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Courses"),
        backgroundColor: const Color.fromARGB(255, 47, 59, 65),
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Consumer<CourseController>(
        builder: (context, controller, child) {

          // Loading
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }

          // Empty
          if (controller.courses.isEmpty) {
            return const Center(
              child: Text("No courses found"),
            );
          }

          // Course List
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.courses.length,
            itemBuilder: (context, index) {
              final CourseModel course =
                  controller.courses[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      course.isFree
                          ? Icons.lock_open
                          : Icons.lock,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(course.title),
                  subtitle: Text(
                    course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    // TODO: Navigate to Course Details
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:machin_task/view/admin/service/course_service.dart';

// class ViewAllCourseScreen extends StatelessWidget {
//   ViewAllCourseScreen({super.key});
//   CourseService courseService = CourseService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         title: Title(color: Colors.black, child: Text("All Course")),
//       ),
//       body: Column(
//         spacing: 20,
//         children: [
          
//         ],
//       ),
//     );
//   }
// }