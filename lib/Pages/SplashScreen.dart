import 'dart:async';

import 'package:flutter/material.dart';

import '../Responsiveness/ResponsiveLayout.dart';
import '../Responsiveness/WebApp.dart';
import 'PageViewScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to MainScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webApp: Webapp(), mobApp: PageViewScreen())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "asset/bg.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
            strokeWidth: 10,
          ),
        ),
      ]),
    );
  }
}
