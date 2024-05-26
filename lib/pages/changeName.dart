import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeDisplayNameScreen extends StatefulWidget {
  const ChangeDisplayNameScreen({super.key});

  @override
  _ChangeDisplayNameScreenState createState() => _ChangeDisplayNameScreenState();
}

class _ChangeDisplayNameScreenState extends State<ChangeDisplayNameScreen> {
  final _displayNameController = TextEditingController();

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _updateDisplayName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(_displayNameController.text);
      Navigator.pushNamed(context, '/');
    } catch (e) {
      print('Failed to update display name: $e');
    }
  }

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
          'Change Display Name',
          style: GoogleFonts.raleway(
              color: const Color(0xFF7AA2E3),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              style: GoogleFonts.kumbhSans(
                  textStyle: const TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: 'New Display Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7AA2E3)),
                  ),
                ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _updateDisplayName,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF97E7E1),
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text('Update Name',
                  style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 24))),
            ),
          ],
        ),
      ),
    );
  }
}