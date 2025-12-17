// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:machin_task/model/admin_model.dart';
// import 'package:machin_task/model/students_model.dart';
// import 'package:machin_task/model/user_model.dart';
// import 'package:machin_task/widget/common.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _database = FirebaseFirestore.instance;

//   Future<String> registerAdmin({
//     required String name,
//     required String email,
//     required String password,
//     required String role,
//     required String phoneNumber,
//     required String schoolName
//    })async{
//     try{
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password
//     );

    
//     String uuid = userCredential.user!.uid;
//     UserModel userModel = UserModel(uuid: uuid, name: name, email: email, role: role);
//     await _database.collection('users').doc(uuid).set(userModel.toJson());

//     AdminModel adminModel = AdminModel(adminId: uuid, name: name, email: email, phoneNumber: phoneNumber, schoolName: schoolName);
//     await _database.collection('admins').doc(uuid).set(adminModel.toJson());
    
//     return "success";
//    }on FirebaseAuthException catch(e){
//     return e.message ?? "Registration Failed";
//    }
//    catch(e){
//     return e.toString();
//    }
//    }
  
//    Future<String> registerStudent({
//     required String adminId,
//     required String teacherId,
//     required String name,
//     required String email,
//     required String password,
//     required String stdClass,
//     required String parentName,
//     required String phone,
//     required String profileImage,
//     required String rollNo,
//     required DateTime dateOfBirth,
//     required DateTime admissionDate,
//     required String role
//     })async{
//       try{
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password
//       );

      
//       String uid = userCredential.user!.uid;
//       UserModel userModel = UserModel(uuid: uid, name: name, email: email, role: role);
//       await _database.collection('users').doc(uid).set(userModel.toJson());

      
//       StudentModel studentModel = StudentModel(uid: uid, name: name, email: email, role: role, profileImage: profileImage, enrolledCourses: enrolledCourses, courseProgress: courseProgress, createdAt: createdAt);
//       await _database.collection('teachers').doc(uid).set(studentModel.toMap());
      
//       return "success";
//     }on FirebaseAuthException catch(e){
//       return e.message ?? "Registration Failed";
//     }
//     catch(e){
//       return e.toString();
//     }
//   } 

//   Future<Map<String,dynamic>> loginUser({required String email,required String password})async{
//     try{
//       UserCredential userCred =  await _auth.signInWithEmailAndPassword(email: email, password: password);
//       String uid = userCred.user!.uid;

//       DocumentSnapshot userDoc = await _database.collection('users').doc(uid).get();
//       if(!userDoc.exists){
//         return {"Status" :"error" , "message" : "User data not Found"};
//       }
//       String role = userDoc['role'];
//       return {"status" : "success", "role" : role};
//     }on FirebaseException catch(e){
//       return {"status" : "error", "message" : e.message ?? "Login Failed"};
//     }catch(e){
//       return {"status" : "error", "message" :e.toString()};
//     }
//    }

//    Future<void> logOut(BuildContext context)async{
//     try {
//      await _auth.signOut();
//      if (context.mounted) {
//        showSnackBarMessage(context, "Logged Out Successfully.");
//      }
//     } catch (e) {
//       if (context.mounted) {
//        showSnackBarMessage(context, "Logout failed : $e");
//       }
//     }
//    }
// }



//   youtube_player_flutter: ^8.0.0
//   url_launcher: ^6.0.0
//   syncfusion_flutter_pdfviewer: ^20.1.0


// Future<String> registerTeacher({
//     required String adminId,
//     required String name,
//     required String password,
//     required String email,
//     required String phone,
//     required String subject,
//     required DateTime dateOfBirth,
//     required DateTime joinDate,
//     required String role
//    })async{
//     try{
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password
//     );

//     String uid = userCredential.user!.uuid;
//     UserModel userModel = UserModel(uuid: uid, name: name, email: email, role: role);
//     await _database.collection('users').doc(uid).set(userModel.toJson());

//     TeacherModel teacherModel = TeacherModel(teacherId: uid, adminId: adminId, name: name, email: email, phone: phone, subject: subject, dateOfBirth: dateOfBirth, joinDate: joinDate);
//     await _database.collection('teachers').doc(uid).set(teacherModel.toJson());
    
//     return "success";
//    }on FirebaseAuthException catch(e){
//     return e.message ?? "Registration Failed";
//    }
//    catch(e){
//     return e.toString();
//    }
//    }