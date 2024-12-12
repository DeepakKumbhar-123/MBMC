import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mbmc/screens/splashScreen.dart';  // Ensure splashScreen.dart exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures proper initialization
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Disable debug banner
      title: 'MBMC App',  // App title
      home: Splashscreen(),  // Ensure SplashScreen is the correct widget
    );
  }
}
