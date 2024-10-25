// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:news_globe/Pages/LoginPage.dart';
// import 'package:news_globe/services/UserAuthentication.dart';
//
// class MyDrawerScreen extends StatefulWidget {
//   const MyDrawerScreen({super.key});
//
//   @override
//   State<MyDrawerScreen> createState() => _MyDrawerScreenState();
// }
//
// class _MyDrawerScreenState extends State<MyDrawerScreen> {
//   String? name = '';
//   String? email = '';
//
//   final authService = UserAuthentication();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }
//
//   void _fetchData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('user')
//           .doc(user.uid)
//           .get();
//       setState(() {
//         name = snapshot['name'];
//         email = snapshot['email'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 child: Text(name != null && name!.isNotEmpty ? name![0] : ""),
//               ),
//               accountName: Text(name ?? "Loading"),
//               accountEmail: Text(email ?? "Loading")),
//           const Divider(),
//           const ListTile(
//             title: Text(
//               "Favourite",
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             trailing: Icon(
//               Icons.favorite,
//               color: Colors.red,
//               size: 30,
//             ),
//           ),
//           const Divider(),
//           ListTile(
//             title: const Text(
//               "Logout",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(
//               Icons.logout,
//               color: Colors.black,
//               size: 30,
//             ),
//             onTap: () {
//               authService.signOut();
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()));
//             },
//           ),
//           const Divider(),
//         ],
//       ),
//     ));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/UserAuthentication.dart';
import '../LoginPage.dart';

class MyDrawerScreen extends StatefulWidget {
  const MyDrawerScreen({super.key});

  @override
  State<MyDrawerScreen> createState() => _MyDrawerScreenState();
}

class _MyDrawerScreenState extends State<MyDrawerScreen> {
  String? name = '';
  String? email = '';
  String? photoUrl = '';

  final authService = UserAuthentication();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      setState(() {
        name = snapshot['name'];
        email = snapshot['email'];
        photoUrl = snapshot['photoUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: photoUrl != null && photoUrl!.isNotEmpty
                    ? NetworkImage(photoUrl!)
                    : null,
                child: photoUrl == null || photoUrl!.isEmpty
                    ? Text(name != null && name!.isNotEmpty ? name![0] : "")
                    : null,
              ),
              accountName: Text(name ?? "Loading"),
              accountEmail: Text(email ?? "Loading")),
          const Divider(),
          const ListTile(
            title: Text(
              "Favourite",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ),
            onTap: () {
              authService.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          const Divider(),
        ],
      ),
    ));
  }
}
