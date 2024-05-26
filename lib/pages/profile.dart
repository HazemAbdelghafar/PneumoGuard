import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bnb.dart';
import '../auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  final name = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6E3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xFF97E7E1),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.raleway(
              color: const Color(0xFF7AA2E3),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              name == 'Hazem' ? const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/myPic.jpeg'),
              ) : const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(name,
                  style: GoogleFonts.raleway(
                      color: const Color(0xFF7AA2E3),
                      fontWeight: FontWeight.w700,
                      fontSize: 24)),
              const SizedBox(height: 10),
              Text(user!.email!,
                  style: GoogleFonts.raleway(
                      color: const Color(0xFF7AA2E3),
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF6AD4DD),
                          ),
                          const SizedBox(width: 15),
                          Text('Change email address',
                              style: GoogleFonts.raleway(
                                  color: const Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF6AD4DD),
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/changeEmail');
                  },
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.lock_outline_rounded,
                            color: Color(0xFF6AD4DD),
                          ),
                          const SizedBox(width: 15),
                          Text('Change your password',
                              style: GoogleFonts.raleway(
                                  color: const Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF6AD4DD),
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/changePassword');
                  },
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Color(0xFF6AD4DD),
                          ),
                          const SizedBox(width: 15),
                          Text('Change display name',
                              style: GoogleFonts.raleway(
                                  color: const Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF6AD4DD),
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/changeDisplayName');
                  },
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFF6AD4DD),
                          ),
                          const SizedBox(width: 15),
                          Text('Logout',
                              style: GoogleFonts.raleway(
                                  color: const Color(0xFF7AA2E3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF6AD4DD),
                        size: 25,
                      ),
                    ],
                  ),
                  onTap: () {
                    Auth().signOut(context: context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F6E3),
      bottomNavigationBar: const myBottomBar(currentIndex: 2),
    );
  }
}
