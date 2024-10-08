import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umratripmanagement/components/my_button.dart';
import 'package:umratripmanagement/components/my_textfield.dart';
import 'package:umratripmanagement/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwpasswordController = TextEditingController();

  // register method
  void registerUser() async {
    // show loading circle 
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
        ),
      );

    //make sure passwords match 
    if (passwordController.text != confirmPwpasswordController.text) {
      // pop loading circle
      if (mounted) Navigator.pop(context);

      // show error messsage to user 
      displayMessageToUser("Passwords don't match!", context);
      return;
    }
    // if passwords do match
    else {
    // try creating the user
      try {
        // create user with email and password
        UserCredential? userCredential = 
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        );

        // pop loading circle 
        if (mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        if (mounted) Navigator.pop(context);

        if (mounted){
          displayMessageToUser(e.code,context);

        }
      }
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

              // username textfield
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),

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

              //confirm password
              MyTextField(
                hintText: "ConfirmPassword",
                obscureText: true,
                controller: confirmPwpasswordController,
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

              // Register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(height: 10),

              // Don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5), // Small gap between text and register link
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login here",
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
