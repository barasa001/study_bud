import 'package:flutter/material.dart';
import 'package:study_bud/firstpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'homepagechat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => StudyBudPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePageChat(),
      },
    );
  }
}
