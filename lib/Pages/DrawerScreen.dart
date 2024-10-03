import 'package:flutter/material.dart';

class Drawerscreen extends StatefulWidget {
  const Drawerscreen({super.key});

  @override
  State<Drawerscreen> createState() => _DrawerscreenState();
}

class _DrawerscreenState extends State<Drawerscreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Drawer());
  }
}
