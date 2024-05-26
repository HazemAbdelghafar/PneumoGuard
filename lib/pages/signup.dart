import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
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
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "CREATE A NEW ACCOUNT",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Color(0xFF7AA2E3),
                              fontWeight: FontWeight.w800,
                              fontSize: 24),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                            hintText: 'Name',
                            hintStyle: GoogleFonts.kumbhSans(
                                textStyle: const TextStyle(
                                    color: Color(0xFF808080),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            prefixIcon: const Icon(Icons.person,
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
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                            ),
                            hintText: 'Email',
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
                            hintStyle: GoogleFonts.raleway(
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
                      const SizedBox(height: 40),
                      ElevatedButton(
                          onPressed: () async {
                            await Auth().createUserWithEmailAndPassword(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF97E7E1),
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Sign up",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24)))),
                      const SizedBox(height: 30),
                      Text('or Sign up with',
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            _handleGoogleSignIn();
                          },
                          child: Image.asset('assets/images/google.png',
                              height: 35, width: 35)),
                      const SizedBox(height: 40),
                      Text('Already have an account?',
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400))),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFF97E7E1), width: 3),
                              backgroundColor: const Color(0xFFF8F6E3),
                              elevation: 0,
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Login",
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
