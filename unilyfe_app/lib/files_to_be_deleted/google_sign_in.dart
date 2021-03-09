import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool _isSigningIn) {
    this._isSigningIn = _isSigningIn;
    notifyListeners();
  }

  String domain(String email) {
    return email.substring(email.indexOf('@') + 1);
  }

  bool isCollegeEmail(String domain) {
    //String expectedDomain = "purdue.edu";
    //for testing purposes, setting it to gmail.com
    var expectedDomain = 'gmail.com';
    if (domain.compareTo(expectedDomain) == 0) {
      return true;
    }
    return false;
  }

  Future logIn() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null || !isCollegeEmail(domain(user.email))) {
      isSigningIn = false;
      return;
    } else {
      // print('Domain ' + domain(user.email));
      // print(domain(user.email).compareTo("gmail.com"));
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
