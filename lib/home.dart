import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth
import 'auth_service.dart';  // Import your AuthService class
import 'base_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();  // Instance of AuthService
  User? _user;

  @override
  void initState() {
    super.initState();

    // Listen for authentication state changes
    _authService.authStateChanges.listen((user) {
      setState(() {
        _user = user;  // Update the user state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // If there's no user, show a default message
    String username = _user != null ? _user!.email!.split('@')[0] : "User";

    return BasePage(
      currentIndex: 1, // 'Home' tab is selected
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting with dynamic username
            Text(
              "Hi $username!",  // Use extracted username or default
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Check out recent questions that have just been posted",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Recent questions list
            Expanded(
              child: ListView(
                children: [
                  _buildQuestionCard(
                    context,
                    username: "user63536732676",
                    subject: "CSC404",
                    question: "Hello, good evening. I am a little confused. How to call a function?",
                    timeAgo: "Posted 3 weeks ago",
                  ),
                  _buildQuestionCard(
                    context,
                    username: "ahmadpintu99",
                    subject: "CSC510",
                    question: "Hi, I didn't understand how this diagram works.",
                    timeAgo: "Posted 3 days ago",
                    image: "assets/diagram_example.png", // Replace with your image asset
                  ),
                  _buildQuestionCard(
                    context,
                    username: "arianagrenade52",
                    subject: "ELC501",
                    timeAgo: "Posted 5 days ago",
                    hasAudio: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    BuildContext context, {
    required String username,
    required String subject,
    String? question,
    String? image,
    required String timeAgo,
    bool hasAudio = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigate to QuestionDetailPage (create this screen)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionDetailPage(
                username: username,
                subject: subject,
                question: question,
                image: image,
                hasAudio: hasAudio,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username and subject
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(subject),
                ],
              ),
              const SizedBox(height: 12),

              // Question or audio player
              if (question != null) ...[
                Text(question),
              ] else if (hasAudio) ...[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.grey),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(thickness: 1, color: Colors.grey),
                        ),
                      ),
                      Icon(Icons.add, color: Colors.grey),
                    ],
                  ),
                ),
              ],

              // Image (if any)
              if (image != null) ...[
                const SizedBox(height: 12),
                Image.asset(image, height: 150, fit: BoxFit.cover),
              ],

              // View answers and time ago
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // You can implement additional logic for viewing answers here
                    },
                    child: const Text("View answers"),
                  ),
                  Text(
                    timeAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

QuestionDetailPage({required String username, required String subject, String? question, String? image, required bool hasAudio}) {
}
