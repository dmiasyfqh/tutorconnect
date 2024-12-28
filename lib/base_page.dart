import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasePage extends StatelessWidget {
  final Widget body; // Body content for individual pages
  final int currentIndex; // Current selected tab index

  const BasePage({super.key, required this.body, required this.currentIndex});

  Future<Map<String, String>> _fetchUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        return {
          'name': data?['name'] ?? 'Your Name',
          'username': data?['username'] ?? 'Your Username',
        };
      }
    }
    return {'name': 'Your Name', 'username': 'Your Username'};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 80.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu), // Hamburger menu icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the navigation drawer
            },
          ),
        ),
        title: Center(
          child: Image.asset(
            'assets/images/logo.png', // Path to your logo file
            height: 60, // Adjust the size as needed
          ),
        ),
        actions: [
          IconButton(
            icon: const Stack(
              children: [
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                    child: Text(
                      '3', // Example notification count
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Navigate to Notifications Page
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<Map<String, String>>(
          future: _fetchUserProfile(), // Fetch user profile from Firestore
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(), // Show loading while fetching data
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading profile'),
              );
            }

            final profile = snapshot.data ?? {'name': 'Your Name', 'username': 'Your Username'};

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: Colors.orange,
                  child: DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png', // Your logo file path
                        height: 70, // Adjust the size as needed
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, color: Colors.grey.shade700),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile['name'] ?? 'Your Name',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "@${profile['username'] ?? 'Your Username'}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About app"),
                  onTap: () {
                    // Navigate to AboutPage
                    Navigator.pushNamed(context, '/about_page');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    // Handle logout action
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: body, // Dynamic content passed to BasePage
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.orange, // Set background color same as AppBar
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.black54, // Unselected item color
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/question.png', // Replace with your question icon path
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: "Questions",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png', // Replace with your home icon path
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/profile.png', // Replace with your profile icon path
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          // Navigate to corresponding pages based on the tapped index
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/myquestions');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
