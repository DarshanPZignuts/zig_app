import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_arguments.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/add_loyalty_card_screen.dart';

class CustomOptionBar extends StatelessWidget {
  ModelLoayltyCard modelLoayltyCard;

  CustomOptionBar({
    Key? key,
    required this.modelLoayltyCard,
  }) : super(key: key);

  DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorManager.white,
            boxShadow: [
              const BoxShadow(
                  color: ColorManager.grey, blurRadius: 2, spreadRadius: 1)
            ]),
        width: 144,
        height: 62,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddLoyaltyCard.id,
                      arguments: LoyaltyCardArguments(
                          docId: modelLoayltyCard.docId,
                          isEditing: true,
                          modelLoayltyCard: modelLoayltyCard));
                  // Navigate to Edit
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: ColorManager.primary, fontSize: FontSize.s12),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () async {
                  await _databaseService
                      .deletCard(modelLoayltyCard.docId ?? "");
                  // delete card
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: ColorManager.primary, fontSize: FontSize.s12),
                ),
              )
            ]),
      ),
    );
  }
}
