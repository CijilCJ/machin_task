import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/screen/add_course_screen.dart';
import 'package:machin_task/view/admin/screen/view_all_course_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ListView(
        children: [
          DrawerHeader(child: Text("admin")),
          ListTile(
            title: Text("Add Course"),
            onTap: () => AddCourseScreen(),
          ),
          ListTile(
            title: Text("All Course"),
            onTap: () => AllCoursesScreen(),
          ),
          ListTile(
            title: Text("LogOut"),
            onTap: () {
              
            },
          )
        ],
      )
    );
  }
}