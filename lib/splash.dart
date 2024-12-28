import 'package:flutter/material.dart';
import 'login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your image here
            Image.asset(
              'assets/images/logo.png', // Path to your image
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(height: 20),
            const Text(
              "Learn Together, Grow Together!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF76d671), // Green color (#76d671)
                minimumSize: const Size(200, 60), // Set the minimum size (width, height)
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40), // Add more padding to make it larger
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.black, // Set the text color to black
                  fontSize: 18, // Adjust font size for bigger text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
