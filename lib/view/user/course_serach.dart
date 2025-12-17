import 'package:flutter/material.dart';

class CourseSearchScreen extends StatefulWidget {
  const CourseSearchScreen({super.key});

  @override
  State<CourseSearchScreen> createState() => _CourseSearchScreenState();
}

class _CourseSearchScreenState extends State<CourseSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Course> allCourses = [
    Course(title: 'Flutter for Beginners', category: 'Mobile', instructor: 'CJ'),
    Course(title: 'Advanced Dart', category: 'Programming', instructor: 'Alex'),
    Course(title: 'Firebase Basics', category: 'Backend', instructor: 'John'),
    Course(title: 'UI/UX Design', category: 'Design', instructor: 'Emma'),
    Course(title: 'MVVM in Flutter', category: 'Architecture', instructor: 'CJ'),
  ];

  List<Course> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    filteredCourses = allCourses;
  }

  void _searchCourse(String query) {
    final result = allCourses.where((course) {
      final titleLower = course.title.toLowerCase();
      final categoryLower = course.category.toLowerCase();
      final instructorLower = course.instructor.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          categoryLower.contains(searchLower) ||
          instructorLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredCourses = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Courses'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchCourse,
              decoration: InputDecoration(
                hintText: 'Search by title, category, instructor',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredCourses.isEmpty
                ? const Center(child: Text('No courses found'))
                : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.school, color: Colors.blue),
                          title: Text(course.title),
                          subtitle: Text('${course.category} • ${course.instructor}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            // Navigate to course details
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}



class Course {
  final String title;
  final String category;
  final String instructor;

  Course({required this.title, required this.category, required this.instructor});
}
