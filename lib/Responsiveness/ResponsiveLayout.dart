import 'package:flutter/cupertino.dart';
import 'package:news_globe/Pages/PageViewScreen.dart';
import 'package:news_globe/Responsiveness/WebApp.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webApp, mobApp;
  const ResponsiveLayout(
      {required this.webApp, required this.mobApp, super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return const PageViewScreen();
        }
        return const Webapp();
      },
    );
  }
}
