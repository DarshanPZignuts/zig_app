import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/services/storage_service.dart';
import 'package:zig_project/ui/dialogs/dialog_box.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/add_loyalty_card_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail/loyalty_card_detail_screen.dart';

class CustomCard extends StatefulWidget {
  final String tittle;
  final String subTittle;
  final Color bgColor;
  final Color circleBgColor;
  ModelLoayltyCard loayltyCard;
  CustomCard(
      {Key? key,
      required this.tittle,
      required this.subTittle,
      required this.bgColor,
      required this.circleBgColor,
      required this.loayltyCard})
      : super(key: key);

  @override
  State<CustomCard> createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool showOption = false;
  StorageService _storageService = StorageService();
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Stack(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoyaltyCardDetail(
                                  modelLoayltyCard: widget.loayltyCard,
                                ))));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.bgColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: widget.circleBgColor,
                        child: Text(
                          widget.tittle.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s20,
                              fontWeight: FontWeightManager.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                          onSelected: (value) async {
                            if (value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AddLoyaltyCard(
                                          docId: widget.loayltyCard.docId,
                                          isEditing: true,
                                          modelLoayltyCard:
                                              widget.loayltyCard))));
                            } else if (value == 2) {
                              showDialog(
                                context: context,
                                builder: (context) => DialogBox.dialogBox(
                                    context: context,
                                    onYes: () async {
                                      Navigator.of(context).pop();
                                      await _databaseService.deletCard(
                                          widget.loayltyCard.docId ?? "");
                                      _storageService.deleteImage(
                                          widget.loayltyCard.cardFrontURL);
                                      _storageService.deleteImage(
                                          widget.loayltyCard.cardBackURL);
                                    },
                                    tittle: StringManager.alertBoxTittle,
                                    content:
                                        StringManager.alertBoxDescription2),
                              );
                            }
                          },
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          itemBuilder: ((context) {
                            return [
                              PopupMenuItem(
                                  value: 1,
                                  height: 20,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontSize: FontSize.s14),
                                  )),
                              const PopupMenuItem(
                                height: 1,
                                child: Divider(),
                              ),
                              PopupMenuItem(
                                value: 2,
                                height: 20,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s14),
                                ),
                              )
                            ];
                          }))
                    ],
                  ),

                  //
                ),
              ]),
              Column(
                children: [
                  Text(
                    widget.tittle,
                    style: getBoldStyle(
                        color: Colors.black, fontSize: FontSize.s14),
                  ),
                  Text(widget.subTittle,
                      style: TextStyle(
                          color: ColorManager.darkGrey,
                          fontSize: 10,
                          letterSpacing: 0.2)),
                ],
              )
            ],
          )),
    );
  }
}
