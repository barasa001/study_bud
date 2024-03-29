import 'package:flutter/material.dart';
import 'package:study_bud/login.dart'; // Import login.dart
import 'package:study_bud/signup.dart'; // Import signup.dart

class StudyBudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading
            Text(
              'Study Bud',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            // Image
            Image.asset(
              'images/study.jpeg', // Replace with the actual name of your image file
              height: 150, // Adjust the height as needed
              width: 150, // Adjust the width as needed
            ),
            // Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignupPage(), // Navigate to SignupPage
                  ),
                );
              },
              child: Text('SIGNUP'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
            // Text below button (Clickable)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(), // Navigate to LoginPage
                  ),
                );
              },
              child: Text(
                'ALREADY HAVE AN ACCOUNT?',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
