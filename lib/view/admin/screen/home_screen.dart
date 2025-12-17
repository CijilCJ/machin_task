import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/model/course_model.dart';
import 'package:machin_task/view/admin/screen/add_course_screen.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

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
        title: const Text("Admin Dashboard"),
        backgroundColor: const Color.fromARGB(255, 47, 59, 65),
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddCourseScreen()));
        },
      ),

      body: Consumer<CourseController>(
        builder: (context, controller, child) {

          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Welcome Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 47, 59, 65),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Admin 👋",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Manage Courses & Students",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Stats Row
                Row(
                  children: [
                    _statCard(
                      title: "Total Courses",
                      value: controller.courses.length.toString(),
                      icon: Icons.book,
                    ),
                    const SizedBox(width: 12),
                    _statCard(
                      title: "Students",
                      value: "—",
                      icon: Icons.people,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  "All Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Course List
                controller.courses.isEmpty
                    ? const Center(
                        child: Text("No courses available"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: controller.courses.length,
                        itemBuilder: (context, index) {
                          final CourseModel course =
                              controller.courses[index];

                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: const Icon(
                                  Icons.book,
                                  color: Colors.black,
                                ),
                              ),
                              title: Text(course.title),
                              subtitle: Text(
                                course.description,
                                maxLines: 2,
                                overflow:
                                    TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      // TODO: Edit course
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      controller
                                          .deleteCourse(course.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.amber),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:machin_task/service/auth_service.dart';
// import 'package:machin_task/view/admin/screen/add_course_screen.dart';
// import 'package:machin_task/view/admin/screen/drawer_screen.dart';
// import 'package:machin_task/view/admin/screen/view_all_course_screen.dart';
// import 'package:machin_task/view/admin/service/course_service.dart';
// import 'package:machin_task/view/admin/widgets/admin_custom.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   final CourseService courseService = CourseService();
//   // final AuthService authService = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerScreen(),
//       appBar:  AppBar(
//         title: Text("Dashboard"),
//       ),
//       body:  GridView.count(
//         crossAxisCount: 2,
//         children: [
//           AdminCard(title: "Add Course", icon: Icons.add_box, onTap: ()=>AddCourseScreen()),
//           AdminCard(title: "View Courses", icon: Icons.list_alt_outlined, onTap: ()=>ViewAllCourseScreen()),
//           AdminCard(title:  "Students", icon: Icons.people, onTap: (){}),
//         ],
//       ),
//     );
//   }
// }