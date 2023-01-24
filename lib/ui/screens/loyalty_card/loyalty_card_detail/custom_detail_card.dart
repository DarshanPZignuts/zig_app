// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_arguments.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/add_loyalty_card_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';

class DetailCard extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;

  DetailCard({
    Key? key,
    required this.modelLoayltyCard,
  }) : super(key: key);

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  bool showOption = false;
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Stack(children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.cardBackground,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: ColorManager.cAvatarBackground,
                              child: Text(
                                widget.modelLoayltyCard.cardName!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: ColorManager.white,
                                    fontSize: 33,
                                    fontWeight: FontWeightManager.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.modelLoayltyCard.cardName!,
                                style: getBoldStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(widget.modelLoayltyCard.programmeName!,
                                  style: TextStyle(
                                      color: ColorManager.darkGrey,
                                      fontSize: 12,
                                      letterSpacing: 0.2)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                          onSelected: (value) => onSelected(value),
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          itemBuilder: ((context) {
                            return [
                              //edit option
                              getPopUpMenuItem(StringManager.editOptionText, 1),
                              const PopupMenuItem(
                                height: 2,
                                child: Divider(),
                              ),
                              //delete option
                              getPopUpMenuItem(
                                  StringManager.deleteOptionText, 2)
                            ];
                          }))
                    ],
                  ),

                  //
                ),
              ]),
            ],
          )),
    );
  }

  PopupMenuItem getPopUpMenuItem(String title, int value) {
    return PopupMenuItem(
      value: value,
      height: 20,
      child: Text(
        title,
        style: TextStyle(color: ColorManager.primary, fontSize: FontSize.s14),
      ),
    );
  }

  Future<void> onSelected(value) async {
    if (value == 1) {
      Navigator.pushNamed(context, AddLoyaltyCard.id,
          arguments: LoyaltyCardArguments(
              docId: widget.modelLoayltyCard.docId,
              isEditing: true,
              modelLoayltyCard: widget.modelLoayltyCard));
    } else if (value == 2) {
      await _databaseService.deletCard(widget.modelLoayltyCard.docId ?? "");
      Navigator.of(context).pushReplacementNamed(LoyaltyCards.id);
    }
  }
}
