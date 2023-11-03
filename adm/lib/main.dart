import 'package:adm/firebase_options.dart';
import 'package:adm/modules/home/home.view.dart';
import 'package:adm/modules/login/login.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Auth App',
      initialRoute: '/login', // Set the initial route to the login screen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) =>
            const HomeScreen(), // Create a HomeScreen for authenticated users
      },
    );
  }
}
