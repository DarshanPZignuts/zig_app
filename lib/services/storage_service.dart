import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:zig_project/user_preferences/user_preferences.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<String>> saveImages(
    File? frontView,
    File? backView,
  ) async {
    String frontpath = frontView!.path;
    String backpath = backView!.path;

    final reference = await _firebaseStorage.ref("userCardImages").child(
        await UserPreferences.getLoginUserInfo()
            .then((value) => value.uid.toString()));

    final frontViewLink =
        await reference.child(frontpath).putFile(frontView).then((p0) {
      return p0.ref.getDownloadURL();
    });

    final backViewLink =
        await reference.child(backpath).putFile(backView).then((p0) {
      return p0.ref.getDownloadURL();
    });
    List<String> list = [frontViewLink, backViewLink];
    return list;
  }

  deleteImage(String? url) {
    if (url != null) _firebaseStorage.refFromURL(url).delete();
  }
}
