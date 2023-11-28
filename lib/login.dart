import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'homepagechat.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true; // password visibility

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await AuthService().signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (user == null) {
          // User doesn't exist or wrong credentials
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('User does not exist or wrong credentials.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Successfully signed in, navigate to the homepage (homepagechat.dart)
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        // Handle any errors that occurred during login
        print('Error: $e');
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // Google Sign In canceled
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  void _loginWithApple() {
    // Add Apple authentication logic here
  }

  Future<void> _resetPassword(BuildContext context) async {
    try {
      _showResetPasswordAlert();

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );

      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _showResetPasswordAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: Text(
              'Enter your email in the email field before clicking on forgot password. A password reset link will be sent to your email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter email...',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email address.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter password...',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                    obscureText: _obscurePassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'or',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _loginWithGoogle,
                  child: Image.asset(
                    'images/google-logo.png',
                    height: 30,
                    width: 30,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: _loginWithApple,
                  child: Image.asset(
                    'images/apple-icon.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text('FORGOT PASSWORD?'),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ),
                );
              },
              child: Text('SIGNUP'),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
