import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zig_project/model/app_user.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/resources/value_manager.dart';

class DatabaseService {
  Auth _auth = Auth();

  final _firebaseFirestore = FirebaseFirestore.instance;

//Stream<QuerySnapshot<Map<String, dynamic>>>
  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamOfLoyaltyCards() {
    return _firebaseFirestore
        .collection("cardsOfUser")
        .doc(_auth.getUser()?.uid)
        .snapshots();
  }

  saveCardDetails(
      {required String cardName,
      required String vendor,
      required String programmeName,
      required String webURL,
      required String note,
      required String cardFrontURL,
      required String cardBackURL,
      required Function onSuccess,
      required Function(String) onError}) async {
    await _firebaseFirestore
        .collection("cardsOfUser")
        .doc(await _auth.getUser()?.uid)
        .update({
          "loyaltyCards": FieldValue.arrayUnion([
            {
              "cardName": cardName,
              "vendor": vendor,
              "programmeName": programmeName,
              "webURL": webURL,
              "note": note,
              "cardFrontURL": cardFrontURL,
              "cardBackURL": cardBackURL
            },
          ])
        })
        .then((value) => {onSuccess()})
        .catchError((e) => {onError(e.toString())});
  }
}
