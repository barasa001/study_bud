import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin.dart'; // Import the admin.dart file

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

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController levelController = TextEditingController();

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
                  controller: passwordController),
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
                  // Implement signup functionality here
                  CollectionReference collRef =
                      FirebaseFirestore.instance.collection('users');
                  collRef.add({
                    'Email': emailController.text,
                    'Password': passwordController.text,
                    'FullName': fullNameController.text,
                    'School': schoolController.text,
                    'Specialization': specializationController.text,
                    'Level': levelController.text,
                  }).then((value) {
                    // Data added to Firestore successfully
                    // You can add additional actions here, like navigating to AdminPage
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPage()));
                  }).catchError((error) {
                    // Handle any errors that occur during the process
                    print("Error: $error");
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text('SIGNUP'),
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

  SignupField(this.label, this.hintText, {required this.controller});

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
