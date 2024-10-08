import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umratripmanagement/components/my_button.dart';
import 'package:umratripmanagement/components/my_textfield.dart';
import 'package:umratripmanagement/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller 
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() async {
    //show loading circle 
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
        ),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

        //pop loading circle 
        if (context.mounted) Navigator.pop(context);


      }
      // display error 
      on FirebaseAuthException catch (e) {
        //pop loading circle 
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            children: [
              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // App name
              const Text(
                "UMRA CONNECT",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

              // Email textfield
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password textfield
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign-in button
              MyButton(
                text: "Login",
                onTap: login,
              ),
              const SizedBox(height: 10),

              // Don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5), // Small gap between text and register link
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
