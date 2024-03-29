import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null; // Return null in case of an unsuccessful login
    }
  }

  // Sign up with email and password
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null; // Return null in case of an unsuccessful sign-up
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  // Check the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
