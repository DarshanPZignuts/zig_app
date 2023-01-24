import 'package:zig_project/model/model_loyalty_card.dart';

class LoyaltyCardArguments {
  ModelLoayltyCard modelLoayltyCard;
  bool? isEditing;
  String? docId;
  LoyaltyCardArguments(
      {required this.modelLoayltyCard, this.isEditing, this.docId});
}
