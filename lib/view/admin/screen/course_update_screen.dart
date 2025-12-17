import 'package:flutter/material.dart';

class CourseUpdateScreen extends StatelessWidget {
  const CourseUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Course Upadate",style: TextStyle(color: Color.fromARGB(255, 47, 59, 65)),),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}