import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/model/course_model.dart';
import 'package:provider/provider.dart';


class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<CourseController>().fetchFreeCourses());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: const Color.fromARGB(255, 47, 59, 65),
        foregroundColor: Colors.amber,
        centerTitle: true,
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

          if (controller.courses.isEmpty) {
            return const Center(
              child: Text("No courses available"),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Greeting Card
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
                        "Welcome 👋",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Start Learning Today!",
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

                const Text(
                  "Free Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Courses List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                          child: const Icon(
                            Icons.play_circle,
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
                          // TODO: Navigate to course details
                        },
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
}






// Nested(
//   children: [], // ❌ EMPTY LIST → CRASH
// )













// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class StudentDashBoard extends StatelessWidget {
//   const StudentDashBoard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//         actions: [
//           IconButton(onPressed: (){}, icon: CircleAvatar())
//         ],
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 350,
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Text("Course Attendance"),
//                   Text("Last Seven Days"),
//                   Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 150,
//                   height: 150,
//                   child: CircularProgressIndicator(
//                     value: 2,
//                     strokeWidth: 12,
//                     backgroundColor: Colors.grey.shade300,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 ]),
//                 Row(
//                   children: [
//                     CircleAvatar(),
//                     Text("Present"),
//                     CircleAvatar(),
//                     Text("leave"),
//                   ],
//                 )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class StudentDashBoard extends StatelessWidget {
//   const StudentDashBoard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double attendance = 0.75;
//     Color progressColor =
//         attendance >= 0.5 ? Colors.green : Colors.red;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const CircleAvatar(
//               backgroundColor: Colors.green,
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(12),
//         children: [
//           Container(
//             height: 350,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 6,
//                 )
//               ],
//             ),
//             child: Column(
//               children: [
//                 const Text(
//                   "Course Attendance",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   "Last Seven Days",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 20),

//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: 150,
//                       height: 150,
//                       child: CircularProgressIndicator(
//                         value: attendance,
//                         strokeWidth: 12,
//                         backgroundColor: Colors.red.shade100,
//                         color: progressColor,
//                       ),
//                     ),
//                     Text(
//                       "${(attendance * 100).toInt()}%",
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 25),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: const [
//                         CircleAvatar(
//                           radius: 6,
//                           backgroundColor: Colors.green,
//                         ),
//                         SizedBox(width: 6),
//                         Text("Present"),
//                       ],
//                     ),
//                     const SizedBox(width: 20),
//                     Row(
//                       children: const [
//                         CircleAvatar(
//                           radius: 6,
//                           backgroundColor: Colors.red,
//                         ),
//                         SizedBox(width: 6),
//                         Text("Leave"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
