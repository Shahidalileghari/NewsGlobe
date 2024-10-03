import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_globe/Pages/HomeScreen.dart';
import 'package:news_globe/Pages/LiveNewsScreen.dart';
import 'package:news_globe/Pages/WatchScreen.dart';

import 'DrawerScreen.dart';
import 'SettingScreen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController pageController = PageController(initialPage: 0);
  int firstScreen = 0;

  List<Widget> screen = [
    const HomeScreen(),
    const WatchScreen(),
    const LiveNewsScreen(),
    const SettingScreen(),
  ];

  void tapScreen(int index) {
    setState(() {
      firstScreen = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawerscreen(),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shadowColor: Colors.grey,
        actions: [
          CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  ))),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                EvaIcons.search,
                size: 34,
                color: Colors.white,
              )),
          // PopupMenuButton<int>(
          //     itemBuilder: (context) => [
          //           const PopupMenuItem(value: 1, child: Text("Share")),
          //           const PopupMenuItem(value: 2, child: Text("Share")),
          //           const PopupMenuItem(value: 3, child: Text("Share")),
          //           const PopupMenuItem(value: 4, child: Text("Share")),
          //           const PopupMenuItem(value: 5, child: Text("Share")),
          //         ]),
        ],
        title: const Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assetName"),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "NewsGlobe",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue, Colors.blueAccent])),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            firstScreen = value;
          });
        },
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.cyan,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: firstScreen,
          onTap: tapScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "watch"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
