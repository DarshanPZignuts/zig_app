import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/user_preferences/user_preferences.dart';

class DatabaseService {
  final Auth _auth = Auth();

  final _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamOfLoyaltyCards() {
    final x = _firebaseFirestore
        .collection("User")
        .doc(_auth.getUser()?.uid)
        .collection("loyaltyCards")
        .snapshots();
    return x;
  }

  deletCard(String docId) async {
    _firebaseFirestore
        .collection("User")
        .doc(
            await UserPreferences.getLoginUserInfo().then((value) => value.uid))
        .collection("loyaltyCards")
        .doc(docId)
        .delete();
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
    DocumentReference reference = _firebaseFirestore
        .collection("User")
        .doc(
            await UserPreferences.getLoginUserInfo().then((value) => value.uid))
        .collection("loyaltyCards")
        .doc();

    reference
        .set({
          "cardName": cardName,
          "vendor": vendor,
          "programmeName": programmeName,
          "webURL": webURL,
          "note": note,
          "cardFrontURL": cardFrontURL,
          "cardBackURL": cardBackURL
        })
        .then((value) => onSuccess)
        .onError((error, stackTrace) => onError);
  }

  updateCardDetails({
    required ModelLoayltyCard modelLoayltyCard,
    required String frontURL,
    required String backURL,
    required String docId,
    required Function onError,
    required Function onSuccess,
  }) async {
    DocumentReference reference = _firebaseFirestore
        .collection("User")
        .doc(
            await UserPreferences.getLoginUserInfo().then((value) => value.uid))
        .collection("loyaltyCards")
        .doc(docId);

    await reference
        .update({
          "cardFrontURL": frontURL,
          "cardBackURL": backURL,
          "cardName": modelLoayltyCard.cardName,
          "vendor": modelLoayltyCard.vendor,
          "programmeName": modelLoayltyCard.programmeName,
          "webURL": modelLoayltyCard.webURL,
          "note": modelLoayltyCard.note,
        })
        .then((value) => onSuccess)
        .onError((error, stackTrace) => onError(error));
  }
}
