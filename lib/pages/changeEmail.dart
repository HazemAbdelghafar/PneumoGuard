import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bnb.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldEmailController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          'Change Email',
          style: GoogleFonts.raleway(
              color: const Color(0xFF7AA2E3),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      backgroundColor: const Color(0xFFF8F6E3),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  style: GoogleFonts.kumbhSans(
                      textStyle: const TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  controller: _oldEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Old Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: GoogleFonts.kumbhSans(
                      textStyle: const TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  controller: _newEmailController,
                  decoration: const InputDecoration(
                    labelText: 'New Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: GoogleFonts.kumbhSans(
                      textStyle: const TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      changeEmail(_oldEmailController.text,
                          _newEmailController.text, _passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF97E7E1),
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text('Submit',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 24))),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const myBottomBar(currentIndex: 2),
    );
  }

  void changeEmail(String oldEmail, String newEmail, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email == oldEmail) {
      try {
        AuthCredential credential =
            EmailAuthProvider.credential(email: oldEmail, password: password);

        await user.reauthenticateWithCredential(credential);

        await user.verifyBeforeUpdateEmail(newEmail);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "A verification email was sent to $newEmail. Please verify your email to update your email address.")),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The email provided is already in use.')),
          );
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The email provided is not valid.')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The password provided is incorrect.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Unknown error occurred.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unknown error occurred.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'The old email provided does not match the current email.')),
      );
    }
  }
}
