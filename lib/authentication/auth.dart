import 'package:firebase_auth/firebase_auth.dart';
import 'package:zig_project/resources/string_manager.dart';

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
        //todo
        return "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return StringManager.networkReqFailed;
      } else if (e.code == 'weak-password') {
        return StringManager.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return StringManager.emailAlreadyUse;
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
        return StringManager.networkReqFailed;
      } else if (e.code == 'user-not-found') {
        return StringManager.userNotFound;
      } else if (e.code == 'wrong-password') {
        return StringManager.wrongPassword;
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
        return StringManager.networkReqFailed;
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
