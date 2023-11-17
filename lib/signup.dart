import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart'; // Import the login page

void main() {
  runApp(SignupApp());
}

class SignupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController levelController = TextEditingController();

  String passwordStrength = '';

  bool isLengthRequirementMet(String password) => password.length >= 8;
  bool containsUpperCase(String password) =>
      password.contains(RegExp(r'[A-Z]'));
  bool containsLowerCase(String password) =>
      password.contains(RegExp(r'[a-z]'));
  bool containsDigit(String password) => password.contains(RegExp(r'[0-9]'));

  void checkPasswordStrength(String password) {
    if (isLengthRequirementMet(password) &&
        containsUpperCase(password) &&
        containsLowerCase(password) &&
        containsDigit(password)) {
      setState(() {
        passwordStrength = 'Strong password';
      });
    } else {
      setState(() {
        passwordStrength = 'Weak password';
      });
    }
  }

  Future<void> _signupWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Successfully signed up, navigate to the login page
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SignupField('Email', 'Enter email...',
                  controller: emailController),
              SignupField('Password', 'Enter password...',
                  controller: passwordController,
                  onChanged: checkPasswordStrength),
              Text(
                passwordStrength,
                style: TextStyle(
                  color: passwordStrength == 'Strong password'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              SignupField('Full Name', 'Enter full name...',
                  controller: fullNameController),
              SignupField('School', 'Enter school...',
                  controller: schoolController),
              SignupField('Specialization', 'Enter specialization...',
                  controller: specializationController),
              SignupField('Level', 'Enter level...',
                  controller: levelController),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _signupWithEmailAndPassword(context);
                },
                child: Text('SIGNUP'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  SignupField(this.label, this.hintText,
      {required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          color: Colors.white,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
