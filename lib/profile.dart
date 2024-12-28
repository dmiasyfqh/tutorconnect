import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController programController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

        // Check if any required field is empty
        bool hasIncompleteData = data?['name'] == '' ||
            data?['username'] == '' ||
            data?['program'] == '' ||
            data?['semester'] == '' ||
            data?['contact'] == '';

        setState(() {
          nameController.text = data?['name'] ?? '';
          usernameController.text = data?['username'] ?? '';
          programController.text = data?['program'] ?? '';
          semesterController.text = data?['semester'] ?? '';
          contactController.text = data?['contact'] ?? '';
          isEditing = hasIncompleteData; // Force editing mode if data is incomplete
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      if (nameController.text.isEmpty ||
          usernameController.text.isEmpty ||
          programController.text.isEmpty ||
          semesterController.text.isEmpty ||
          contactController.text.isEmpty) {
        Fluttertoast.showToast(msg: "All fields must be filled in.");
        return;
      }

      await _firestore.collection('users').doc(currentUser.uid).set({
        'name': nameController.text,
        'username': usernameController.text,
        'program': programController.text,
        'semester': semesterController.text,
        'contact': contactController.text,
      }, SetOptions(merge: true));

      Fluttertoast.showToast(msg: "Profile updated successfully.");
      setState(() {
        isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 2,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile header section
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isEditing
                ? TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  )
                : Text(
                    nameController.text,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 5),
            isEditing
                ? TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  )
                : Text(
                    "@${usernameController.text}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
            const SizedBox(height: 20),
            // Profile details section
            isEditing
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: programController,
                        decoration: const InputDecoration(labelText: 'Program'),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: semesterController,
                        decoration: const InputDecoration(labelText: 'Semester'),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: contactController,
                        decoration: const InputDecoration(labelText: 'Contact Info'),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Program: ${programController.text}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Semester: ${semesterController.text}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Contact info: ${contactController.text}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    _updateUserData();
                  } else {
                    isEditing = true;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7D3FFC),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(isEditing ? 'Save Changes' : 'Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
