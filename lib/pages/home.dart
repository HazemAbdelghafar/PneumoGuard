import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bnb.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final name = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6E3),
        automaticallyImplyLeading: false,
        title: Text('👋🏻 Hi $name!',
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Color(0xFF7AA2E3),
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            )),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: name == 'Hazem' ? const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/myPic.jpeg'),
              ) : const CircleAvatar(
                radius: 20,
                child: Icon(Icons.person, size: 25),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/detection');
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(340, 115),
                        backgroundColor: const Color(0x9997E7E1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Pneumonia\nDetection',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    color: Color(0xFF7AA2E3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              )),
                        ),
                        const SizedBox(width: 75),
                        Image.asset('assets/images/detection.png')
                      ],
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/hospitals');
                    },
                    style: ElevatedButton.styleFrom(
                        // padding: const EdgeInsets.only(right: 0),
                        fixedSize: const Size(340, 115),
                        elevation: 0,
                        backgroundColor: const Color(0x9997E7E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hospitals',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(width: 120),
                        Image.asset('assets/images/hospitals.png')
                      ],
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(340, 115),
                        elevation: 0,
                        backgroundColor: const Color(0x9997E7E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Online Chat',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    color: Color(0xFF7AA2E3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              )),
                        ),
                        const SizedBox(width: 100),
                        Image.asset('assets/images/chat.png')
                      ],
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(340, 115),
                        elevation: 0,
                        backgroundColor: const Color(0x9997E7E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Profile',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    color: Color(0xFF7AA2E3),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              )),
                        ),
                        const SizedBox(width: 112),
                        Image.asset('assets/images/app_logo.png')
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const myBottomBar(currentIndex: 0),
    );
  }
}
