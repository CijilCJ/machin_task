import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/model/course_model.dart';
import 'package:machin_task/view/user/student_profile.dart';
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
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentProfile()));
            }, 
            icon: CircleAvatar(

            )
          )
        ],
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

                 SizedBox(height: 24),

                 Text(
                  "Free Courses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 SizedBox(height: 12),

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