import 'package:flutter/material.dart';

class Webapp extends StatefulWidget {
  const Webapp({super.key});

  @override
  State<Webapp> createState() => _WebappState();
}

class _WebappState extends State<Webapp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome to webApp"),
      ),
    );
  }
}
