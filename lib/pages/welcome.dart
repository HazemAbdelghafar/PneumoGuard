import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F6E3),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Text("Welcome to PneumoGuard",
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28))),
                      Text(
                        "Empowering Precision\nRedifining Care",
                        style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                                color: Color(0xFF7AA2E3),
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Image.asset('assets/images/welcome.png'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF97E7E1),
                              fixedSize: const Size(250, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Login",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24)))),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFF97E7E1), width: 3),
                              backgroundColor: const Color(0xFFF8F6E3),
                              elevation: 0,
                              fixedSize: const Size(250, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text("Sign up",
                              style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24))))
                    ],
                  ))),
        ));
  }
}
