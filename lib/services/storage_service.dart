import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:zig_project/services/authentication/auth.dart';

class StorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Auth _auth = Auth();

  Future<List<String>> saveImages(File? frontView, File? backView) async {
    final reference = await _firebaseStorage
        .ref("userCardImages")
        .child(await _auth.getUser()!.uid)
        .child("1");

    final frontViewLink =
        await reference.child("front").putFile(frontView!).then((p0) {
      return p0.ref.getDownloadURL();
    });

    final backViewLink =
        await reference.child("back").putFile(backView!).then((p0) {
      return p0.ref.getDownloadURL();
    });
    List<String> list = [frontViewLink, backViewLink];
    return list;
  }
}
