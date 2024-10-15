import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_globe/Pages/WebApplication/WebApp.dart';
import 'package:news_globe/Responsiveness/ResponsiveLayout.dart';

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
    toNextScreen();
  }

  void toNextScreen() {
    Timer(const Duration(milliseconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  webApp: Webapp(), mobApp: PageViewScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "asset/bg.jfif",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          const SpinKitFadingCircle(
            color: Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
