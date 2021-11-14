import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _uid;
  String? _token;

  String? get uid => _uid;
  String? get token => _token;

  Future<void> signUp(String email, String password) async {
    var firebaseRef = FirebaseAuth.instance;
    var sharedRef = await SharedPreferences.getInstance();

    var response = await firebaseRef.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    _uid = response.user!.uid;
    _token = await response.user!.getIdToken();

    sharedRef.setString('uid', _uid!);
    sharedRef.setString('token', _token!);
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    var firebaseRef = FirebaseAuth.instance;
    var sharedRef = await SharedPreferences.getInstance();

    var response = await firebaseRef.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    _uid = response.user!.uid;
    _token = await response.user!.getIdToken();

    sharedRef.setString('uid', _uid!);
    sharedRef.setString('token', _token!);
    notifyListeners();
  }

  Future<void> logOut() async {
    var sharedRef = await SharedPreferences.getInstance();
    _uid = null;
    _token = null;
    await FirebaseAuth.instance.signOut();
    sharedRef.clear();
    notifyListeners();
  }

  Future<void> getData() async {
    var sharedRef = await SharedPreferences.getInstance();
    _uid = sharedRef.getString('uid');
    _token = sharedRef.getString('token');
  }
}
