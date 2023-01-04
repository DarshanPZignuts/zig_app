import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

// Create user with email and password.......

  Future<User?> createNewAccount(String email, String password) async {
    try {
      UserCredential usercredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = usercredential.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

//Login user with email and pass word.........

  Future<User?> logInwithEmailandpassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  //SIGN OUT....

  signOut() {
    _firebaseAuth.signOut();
  }
}
