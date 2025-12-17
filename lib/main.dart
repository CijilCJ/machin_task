import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/screen/home_screen.dart';
import 'package:machin_task/view/admin/screen/view_all_course_screen.dart';
import 'package:machin_task/view/user/splash_screen.dart';
import 'package:machin_task/view/user/student_profile.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> CourseController())
    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllCoursesScreen(),
    )
    );
  }
}