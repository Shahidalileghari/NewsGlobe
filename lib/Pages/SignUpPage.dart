import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For file uploads
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsglobe/Pages/LoginPage.dart';
import 'package:newsglobe/Pages/MobileApplication/PageViewScreen.dart';
import 'package:newsglobe/Pages/WebApplication/WebApp.dart';
import 'package:newsglobe/Responsiveness/ResponsiveLayout.dart';
import 'package:newsglobe/services/UserAuthentication.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  late var _nameController = TextEditingController();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();
  late var _confirmPasswordController = TextEditingController();
  File? _image; // To hold the picked image
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  //
  // creating object of UserAuthentication
  final auth = UserAuthentication();

  // Method to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store picked image
      });
    }
  }

  // Method to upload image to Firebase Storage
  Future<String?> _uploadImageToFirebase() async {
    if (_image == null) return null; // If no image is selected

    try {
      String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL(); // Get the image URL
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _signUp() async {
    // Check if form is valid
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Start showing the loading indicator
      });

      // Upload image and get the download URL
      String? imageUrl = await _uploadImageToFirebase();

      User? user = await auth.signUp(_emailController.text.trim(),
          _passwordController.text.trim(), _nameController.text.trim());

      setState(() {
        _isLoading = false;
      });

      // Simulate a sign-up process delay using Future.delayed
      await Future.delayed(const Duration(seconds: 2));
      if (user != null) {
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-Up Successful!')),
        );

        // Navigate to home screen after successful sign-up
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                    webApp: Webapp(), mobApp: PageViewScreen())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign Up Failed. Try again.')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the controllers in initState
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validators for the input fields
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
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
            height: 680,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                    padding: EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Signup here"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Profile Picture Picker
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage, // Pick image when clicked
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null, // Display picked image
                        child: _image == null
                            ? const Icon(Icons.camera_alt, size: 50)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      validator: _validateName, // Name validator
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      validator:
                          _validateConfirmPassword, // Confirm password validator
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _isLoading
                        ? null
                        : () {
                            _signUp();
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
                            : const Center(child: Text("Sign up")),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already a user?"),
                            SizedBox(width: 4),
                            Text("Login here"),
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
