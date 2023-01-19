import 'package:firebase_auth/firebase_auth.dart';
import 'package:zig_project/model/app_user.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/user_preferences/user_preferences.dart';

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
      User? user = usercredential.user;

      if (user != null) {
        await user.updateDisplayName(username);
        //todo
        await UserPreferences.saveLoginUserInfo(AppUser(
            email: email,
            isSignIn: true,
            name: user.displayName,
            uid: user.uid));
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
    return null;
  }

//Login user with email and pass word.........

  Future<String?> logInwithEmailandpassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await UserPreferences.saveLoginUserInfo(AppUser(
            email: email,
            isSignIn: true,
            name: user.displayName,
            uid: user.uid));
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
    return null;
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
    return null;
  }

  //SIGN OUT....

  signOut() async {
    await UserPreferences.clearDetailsOnSignOut();
    await _firebaseAuth.signOut();
  }
}
