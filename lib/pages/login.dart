import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F6E3),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F6E3),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Color(0xFF97E7E1),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/welcome');
            },
          ),
        ),
        body: SafeArea(
          child: Container(
              alignment: Alignment.center,
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('assets/images/app_logo.png',
                          width: 125, height: 125),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                            ),
                            hintStyle: GoogleFonts.kumbhSans(
                                textStyle: const TextStyle(
                                    color: Color(0xFF808080),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0xFF808080)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color(0xFF97E7E1), width: 3)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                            ),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.kumbhSans(
                                textStyle: const TextStyle(
                                    color: Color(0xFF808080),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF808080),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color(0xFF97E7E1), width: 3)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFF97E7E1),
                                    decorationThickness: 2,
                                    color: Color(0xFF97E7E1),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16)),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/resetPassword');
                          }),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            await Auth().signInWithEmailAndPassword(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF97E7E1),
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Login",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24)))),
                      const SizedBox(height: 20),
                      Text('or Sign up with',
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))),
                      GestureDetector(
                          child: Image.asset('assets/images/google.png',
                              height: 35, width: 35),
                          onTap: () {
                            _handleGoogleSignIn();
                          }),
                      const SizedBox(height: 30),
                      Text("Don't have an account?",
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFF97E7E1), width: 3),
                              backgroundColor: const Color(0xFFF8F6E3),
                              elevation: 0,
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Sign up",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24))))
                    ],
                  ),
                ),
              )),
        ));
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(googleAuthProvider);
      if (userCredential.user != null) {
        // Navigate to the home page
        Navigator.pushNamed(context, '/');
      }
    } catch (e) {
      // print(e);
    }
  }
}
