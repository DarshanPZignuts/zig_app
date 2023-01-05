import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

// Create user with email and password.......

  Future<String?> createNewAccount(String email, String password) async {
    try {
      UserCredential usercredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = usercredential.user;
      if (user != null) {
        return "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
  }

//Login user with email and pass word.........

  Future<String?> logInwithEmailandpassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        return "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
  }

//Change Password....

  Future<String?> changePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  //SIGN OUT....

  signOut() {
    _firebaseAuth.signOut();
  }
}
