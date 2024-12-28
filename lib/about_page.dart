import 'package:flutter/material.dart';
import 'base_page.dart'; // Ensure this imports your BasePage file

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1, // Update to the correct index for navigation (e.g., Home tab index)
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo at the top
              Center(
                child: Image.asset(
                  'assets/images/logo.png', // Replace with the actual path to your logo
                  height: 100, // Adjust the size as needed
                ),
              ),
              const SizedBox(height: 16),
              // Title
              const Text(
                "TutorConnect",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                "TutorConnect is a platform that enables students to academically interact by featuring a Q&A community where students can post questions and get answers from peers, fostering collaborative learning.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              // Features
              const Text(
                "Features:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.question_answer, color: Colors.orange),
                    title: Text(
                      "Q&A Community",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Post questions and receive answers from peers to foster collaborative learning.",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.text_fields, color: Colors.orange),
                    title: Text(
                      "Text Recognition with Google ML Kit",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Convert text from images for easy sharing of notes.",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.schedule, color: Colors.orange),
                    title: Text(
                      "Tutor Availability Schedules",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Check when tutors are available to provide support.",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.orange),
                    title: Text(
                      "Instant Notifications",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Stay updated with real-time notifications.",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.orange),
                    title: Text(
                      "Supportive Network",
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Build a strong campus community through peer collaboration.",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Closing Statement
              const Text(
                "TutorConnect empowers students to succeed academically while building a strong campus community.",
                style: TextStyle(fontSize: 16, height: 1.5, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
