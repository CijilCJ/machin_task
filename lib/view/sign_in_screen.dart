import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machin_task/view/sign_up_screen.dart';
import 'package:machin_task/view/user/bottom_nav_bar.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn signIn=GoogleSignIn.instance;
  bool isLoading = false;

  
Future<void> googleLogin() async {
    try {
      setState(() => isLoading = true);

      // Google sign-in
      // final GoogleSignInAccount? googleUser =
      //     await GoogleSignIn().signIn();
      
      await signIn.initialize(
        serverClientId: "7027983878-a9aomlgj5hkcvpl2kpfkl4j4e3hauupg.apps.googleusercontent.com"
      );
      final account=await signIn.authenticate();

      if (account == null) {
        setState(() => isLoading = false);
        return;
      }

      final  googleAuth =
          await account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Firebase login
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCred.user!;
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      // Create user if first time
      final snapshot = await userRef.get();
      if (!snapshot.exists) {
        await userRef.set({
          'name': user.displayName,
          'email': user.email,
          'role': 'student'??'admin', // default role
          'profileImage': user.photoURL ?? '',
          'createdAt': Timestamp.now(),
        });
      }

      Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavBar()));
      
    } on GoogleAuthProvider{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
      log(e.toString());
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
      log(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 59, 65),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 90, color: Colors.amber),

              const SizedBox(height: 20),

              const Text(
                "APTCODER EdTech",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Explore • Learn • Succeed",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: isLoading ? null : googleLogin,
                  icon: Icon(Icons.g_mobiledata_rounded, color: Colors.white),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>EmailLoginScreen()));},
                  icon: Icon(Icons.login, color: Colors.white),
                ),
              ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}








class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => isLoading = true);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));

    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = "No account found for this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
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
                  "Email Login",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),

                const SizedBox(height: 30),

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
                  obscureText: obscure,
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
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() => obscure = !obscure);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
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
                    onPressed: isLoading ? null : loginUser,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
        borderSide: const BorderSide(color: Colors.amber, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}









              // SizedBox(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton.icon(
              //     icon: const Icon(Icons.login),
              //     label: isLoading
              //         ? const CircularProgressIndicator(
              //             color: Colors.black,
              //           )
              //         : const Text(
              //             "Sign in with Google",
              //             style: TextStyle(fontSize: 16),
              //           ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.amber,
              //       foregroundColor: Colors.black,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     onPressed: isLoading ? null : googleLogin,
              //   ),
              // ),

