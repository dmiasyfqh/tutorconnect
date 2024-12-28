import 'package:flutter/material.dart';
import 'base_page.dart';

class MyQuestionsPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  MyQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 0, // 'My Questions' tab is selected
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search for questions...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) {
                      // Add logic for filtering questions based on the search query
                    },
                  ),
                ),

                // List of Questions
                Expanded(
                  child: ListView(
                    children: [
                      _buildQuestionCard(
                        username: "user63536732676",
                        subject: "CSC404",
                        question: "Hello, good evening. How to call a function?",
                        timeAgo: "3 weeks ago",
                      ),
                      _buildQuestionCard(
                        username: "ahmadpintu99",
                        subject: "CSC510",
                        question: "I didn't understand how this diagram works.",
                        timeAgo: "1 hour ago",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.pushNamed(context, '/addquestion');
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({
    required String username,
    required String subject,
    required String question,
    required String timeAgo,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.person, color: Colors.white),
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

            // Question Text
            Text(question),

            // Time Ago
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Add logic for viewing question details
                  },
                  child: const Text("View details"),
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
    );
  }
}
