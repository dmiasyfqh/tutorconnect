import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'home.dart';
import 'profile.dart';
import 'my_questions.dart';
import 'add_question.dart';
import 'notifications.dart';
import 'splash.dart';
import 'signup.dart';
import 'about_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter engine is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  print("Firebase initialized successfully!"); // Debug statement
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Connect',
      debugShowCheckedModeBanner: false, // Disable the debug banner
      initialRoute: '/splash', // Set Splash screen as initial route
      routes: {
        '/splash': (context) => const Splash(), // Register Splash page route
        '/login': (context) => Login(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/myquestions': (context) => MyQuestionsPage(),
        '/addquestion': (context) => const AddQuestion(),
        '/notifications': (context) => const Notifications(),
        '/signup': (context) => Signup(),
        '/about_page': (context) => const AboutPage(),
      },
    );
  }
}
