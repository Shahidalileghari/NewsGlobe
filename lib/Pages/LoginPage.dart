import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../responsiveness/ResponsiveLayout.dart';
import '../services/UserAuthentication.dart';
import 'MobileApp/PageViewScreen.dart';
import 'SignUpPage.dart';
import 'WebApp/WebApp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();

  bool _isLoading = false;
  final validateUser = UserAuthentication();
  //
  void _signIn() async {
    // Check if form is valid
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Start showing the loading indicator
      });
      User? user = await validateUser.signIn(
          _emailController.text.trim(), _passwordController.text.trim());
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ResponsiveLayout(
                      webApp: Webapp(), mobApp: PageViewScreen())));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }

      // Simulate a sign-up process delay using Future.delayed
      await Future.delayed(const Duration(seconds: 2));

      // setState(() {
      //   _isLoading = false; // Stop showing the loading indicator
      // });
      //
      // // Sign-up process is complete, show a success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Sign-Up Successful!')),
      // );
    }
  }

  //
  @override
  void initState() {
    super.initState();
    // Initialize the controllers in initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+\w{2,4}').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 350,
            height: 570,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome to NewsGlobe"),
                          Text("Discover what is happening"),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Login here"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      validator: _validateEmail, // Email validator
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      validator: _validatePassword, // Password validator
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _isLoading
                        ? null
                        : () {
                            _signIn();
                          },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 2,
                              )
                            : const Center(child: Text("Login")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New user?"),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Sign here"),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
