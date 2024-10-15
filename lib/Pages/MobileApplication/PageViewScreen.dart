import 'package:flutter/material.dart';
import 'package:news_globe/Pages/MobileApplication/CategoryNewsScreen.dart';
import 'package:news_globe/Pages/MobileApplication/HomeScreen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;
  List<Widget> screen = [const HomeScreen(), const CategoryNewsScreen()];
  void nextScreen(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text("NewsGlobe"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
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
