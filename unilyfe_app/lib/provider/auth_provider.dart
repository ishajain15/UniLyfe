import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool newUser = false;

  Stream<String> get authStateChanges => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  Future<String> getCurrentUID() async {
    return await _firebaseAuth.currentUser.uid;
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update the username
    await updateUserName(name, currentUser.user);
    setNewUser(true);
    return currentUser.user.uid;
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateProfile(displayName: name);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Sign Out
  Future<void> signOut() {
    _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Send Email Verification
  Future sendEmailVerification() async {
    return _firebaseAuth.currentUser.sendEmailVerification();
  }

  bool getNewUser() {
    return newUser;
  }

  bool setNewUser(bool isNewUser) {
    newUser = isNewUser;
  }

  // Google Sign-in
  Future<String> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    //idea to ensure it is college email over here
    //check if domain is college email, if not sign out and never update on firebase
    if (!isCollegeEmail(domain(account.email))) {
      print('GOOGLE EMAIL IS NOT COLLEGE EMAIL: ' + account.email);
      await _googleSignIn.signOut();
      return null;
    }
    final _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}

//THIS IS THE FUNCTION TO VERIFY IF IT'S A COLLEGE EMAIL
String domain(String email) {
  return email.substring(email.indexOf('@') + 1);
}

bool isCollegeEmail(String domain) {
  //for testing purposes, adding gmail.com as an option
  if (domain.compareTo('gmail.com') == 0 ||
      domain.compareTo('purdue.edu') == 0) {
    return true;
  }
  return false;
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name must be less than 50 characters long';
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    if (!isCollegeEmail(domain(value))) {
      return domain(value) + ' is not a college email';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
