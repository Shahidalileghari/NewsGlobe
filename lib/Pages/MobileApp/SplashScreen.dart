import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../responsiveness/ResponsiveLayout.dart';
import '../LoginPage.dart';
import '../WebApp/WebApp.dart';
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
    _checkUserSession();
  }

  _checkUserSession() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void toNextScreen() {
    Timer(const Duration(milliseconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                    webApp: Webapp(), mobApp: PageViewScreen())));
      }
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
