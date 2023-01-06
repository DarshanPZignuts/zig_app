import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

//User
  User? getUser() {
    return _firebaseAuth.currentUser;
  }

// Create user with email and password.......

  Future<String?> createNewAccount(
      {required String email,
      required String password,
      required String username}) async {
    try {
      UserCredential usercredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = await usercredential.user;
      await user?.updateDisplayName(username);
      if (user != null) {
        return "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return 'No Internet Connection';
      } else if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for this email.';
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
      if (e.code == 'network-request-failed') {
        return 'No Internet Connection';
      } else if (e.code == 'user-not-found') {
        return 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for this user.';
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return 'No Internet Connection';
      }
    } catch (e) {
      return e.toString();
    }
  }

  //SIGN OUT....

  signOut() {
    _firebaseAuth.signOut();
  }
}
