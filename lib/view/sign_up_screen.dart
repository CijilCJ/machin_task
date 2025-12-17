import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machin_task/view/user/bottom_nav_bar.dart';
import 'package:machin_task/view/user/student_dash_board.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => isLoading = true);

      // Create user
      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCred.user!;

      // Save user in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'student', // default role
        'profileImage': '',
        'createdAt': Timestamp.now(),
      });

      // Navigate to splash
      Navigator.pushReplacementNamed(context, '/splash');
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed";

      if (e.code == 'email-already-in-use') {
        message = "Email already registered";
      } else if (e.code == 'weak-password') {
        message = "Password should be at least 6 characters";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 59, 65),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(Icons.school, size: 90, color: Colors.amber),

                const SizedBox(height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),

                const SizedBox(height: 30),

                // Name
                TextFormField(
                  controller: nameController,
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? "Name is required"
                          : null,
                  decoration: _inputDecoration(
                    label: "Full Name",
                    icon: Icons.person,
                  ),
                ),

                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!value.contains('@')) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                    label: "Email",
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Minimum 6 characters";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                    label: "Password",
                    icon: Icons.lock,
                    suffix: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() =>
                            obscurePassword = !obscurePassword);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirm,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password required";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(
                    label: "Confirm Password",
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() =>
                            obscureConfirm = !obscureConfirm);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const BottomNavBar()));
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.amber),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white38),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Colors.amber, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:machin_task/widget/common.dart';

// class SignUpScreen extends StatelessWidget {

//   SignUpScreen({super.key});

//   final nameCntrl=TextEditingController();
//   final emailCntrl=TextEditingController();
//   final phoneCntrl=TextEditingController();
//   final classCntrl=TextEditingController();
//   final schoolCntrl=TextEditingController();
//   final parentCntrl=TextEditingController();
//   final parentNumberCntrl=TextEditingController();
//   final passswordCntrl=TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child:Form(
//           child: Column(
//             children: [
//               textFormField(nameCntrl, "name", Icons.person, (){}),
//               textFormField(emailCntrl, "email", Icons.mail, (){}),
//               textFormField(phoneCntrl, "phone", Icons.phone, (){}),
//               textFormField(parentCntrl, "parent name", Icons.person, (){}),
//               textFormField( parentNumberCntrl, "parent number", Icons.phone, (){}),
//               textFormField(classCntrl, "class", Icons.class_, (){}),
//               textFormField(schoolCntrl, "school name", Icons.school, (){}),
//               textFormField(passswordCntrl, "password", Icons.remove_red_eye, (){}),

//               ElevatedButton(onPressed: (){}, child: Text("Save")),
//                Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account? "),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => SignUpScreen()),
//                       );
//                     },
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               GestureDetector(
//                   onTap: (){
  
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blue, width: 2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.g_mobiledata),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }