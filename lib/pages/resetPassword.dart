import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6E3),
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
          'Reset password',
          style: GoogleFonts.raleway(
              color: const Color(0xFF7AA2E3),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
                style: GoogleFonts.kumbhSans(
                    textStyle: const TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
                controller: emailController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                  ),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old email';
                  }
                  return null;
                }),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await Auth().sendPasswordResetEmail(emailController.text);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF97E7E1),
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text(
                'Submit',
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
