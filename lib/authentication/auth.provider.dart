import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/authentication/landing.dart';

class AuthProvider extends ChangeNotifier {
  //listen user exist or not
  AuthProvider._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }
  // call current user
  User? get user => FirebaseAuth.instance.currentUser;

  factory AuthProvider() => AuthProvider._();

  static AuthProvider get instance => AuthProvider();

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(
      String name, String email, String phone, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) =>
            {FirebaseAuth.instance.currentUser!.updateDisplayName(name)});
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
        (route) => false);
  }
}
