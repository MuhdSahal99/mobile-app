import 'package:flutter/material.dart';
import 'package:umratripmanagement/auth/auth.dart';
import 'package:umratripmanagement/firebase_options.dart';
import 'package:umratripmanagement/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/dark_mode.dart';
import 'theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      
    );
  }
}