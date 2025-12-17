import 'package:flutter/material.dart';
import 'package:machin_task/view/user/course_serach.dart';
import 'package:machin_task/view/user/student_dash_board.dart';
import 'package:machin_task/view/user/student_profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _currentindex=0;
  List screen=[
    StudentDashboard(),
    CourseSearchScreen(),
    StudentProfile()
  ];
  void onTap(int index){
    setState(() {
      _currentindex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentindex],
     bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentindex,
      backgroundColor: const Color.fromARGB(255, 47, 59, 65),
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),

     ]),
    );
  }
}
