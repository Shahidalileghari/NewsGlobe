import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CategoryNewsScreen.dart';
import 'HomeScreen.dart';
import 'MyDrawerScreen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const CategoryNewsScreen(),
  ];
  void nextScreen(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authServices = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      drawer: const MyDrawerScreen(),
      appBar: AppBar(
        leading: null,
        title: const Text(
          "NewsGlobe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            // child: InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const SearchScreen()));
            //   },
            //   child: const Icon(
            //     Icons.search,
            //     size: 34,
            //     color: Colors.white,
            //   ),
            // ),
          ),
        ],
      ),
      // drawer: const MyDrawerScreen(),
      body: PageView(
        controller: pageController,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.red,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: nextScreen,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 34,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                  size: 34,
                ),
                label: "Categories"),
          ]),
    );
  }
}
