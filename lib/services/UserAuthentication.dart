import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthentication {
  final _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await fireStore
            .collection('user')
            .doc(user.uid)
            .set({'name': name, 'email': email});
      }
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {}

      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
