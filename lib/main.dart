import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:pneumoguardapp/pages/changeName.dart';

import 'consts.dart';
import 'firebase_options.dart';
import 'pages/changeEmail.dart';
import 'pages/changePassword.dart';
import 'pages/chat.dart';
import 'pages/detection.dart';
import 'pages/home.dart';
import 'pages/hospitals.dart';
import 'pages/login.dart';
import 'pages/profile.dart';
import 'pages/resetPassword.dart';
import 'pages/signup.dart';
import 'pages/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Gemini.init(apiKey: GEMINI_API_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PneumoGuard',
      initialRoute: '/welcome',
      routes: {
        '/': (context) => Home(),
        '/chat': (context) => const Chat(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/welcome': (context) => const Welcome(),
        '/profile': (context) => const Profile(),
        '/detection': (context) => const Detection(),
        '/hospitals': (context) => const HospitalsScreen(),
        '/resetPassword': (context) => const ResetPassword(),
        '/changeEmail': (context) => const ChangeEmailScreen(),
        '/changePassword': (context) => const ChangePasswordScreen(),
        '/changeDisplayName': (context) => const ChangeDisplayNameScreen(),
      },
    );
  }
}
