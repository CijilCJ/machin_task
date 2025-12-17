import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Profile"),
        backgroundColor: const Color.fromARGB(255, 47, 59, 65),
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // Name
            const Text(
              "",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Email
            const Text(
              "",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // Info Cards
            _profileTile(Icons.phone, "Phone", ""),
            _profileTile(Icons.school, "Role", "Student"),
            _profileTile(Icons.book, "Courses", "Free Courses"),

            const Spacer(),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // TODO: Logout logic
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:machin_task/controller/auth_controller.dart';

// class StudentProfile extends StatelessWidget {
//   final AuthController authController= AuthController();
//    StudentProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PROFILE"),
//         actions: [
//           IconButton(onPressed: (){}, icon: Icon(Icons.edit))
//         ],

//       ),
//       body: ListView(
//         children: [
//           Container(
//             height: 350,
//             width: double.infinity,
//             child: Expanded(child: Row(children: [
//               CircleAvatar(
//                 // profile image add and edit
//               ),
//               Column(
//                 children: [
//                 Text("Name : "),
//                 Text("Age: "),
//                 Text("course: "),
//                 Text("data "),
//                 Text("data "),
//                 Text("data "),
//                 ],
//               )
//             ],)),
//           )
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:machin_task/controller/auth_controller.dart';

// class StudentProfile extends StatelessWidget {
//   // final AuthController authController = AuthController();

//   StudentProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("PROFILE"),
//         actions: [
//           IconButton(
//             onPressed: () {
            
//             },
//             icon: const Icon(Icons.edit),
//           ),
//         ],
//       ),

//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [

//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 6,
//                 )
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Stack(
//                   children: [
//                     const CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.grey,
//                       child: Icon(Icons.person, size: 40, color: Colors.white),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: CircleAvatar(
//                         radius: 14,
//                         backgroundColor: Colors.green,
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),

//                 SizedBox(width: 20),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children:[

//                       ProfileText(label: "Name", value: "CJ"),
//                       ProfileText(label: "Age", value: "21"),
//                       ProfileText(label: "Course", value: "Flutter"),
//                       ProfileText(label: "Email", value: "cj@gmail.com"),
//                       ProfileText(label: "Phone", value: "+91 9876543210"),

//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProfileText extends StatelessWidget {
//   final String label;
//   final String value;

//   const ProfileText({
//     super.key,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: RichText(
//         text: TextSpan(
//           text: "$label : ",
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//           children: [
//             TextSpan(
//               text: value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
