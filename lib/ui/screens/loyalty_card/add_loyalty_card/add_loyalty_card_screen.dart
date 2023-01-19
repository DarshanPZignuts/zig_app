import 'dart:io';
import 'package:flutter/material.dart';

import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/services/storage_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/card_image_section.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/form_section.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';

import 'package:zig_project/ui/widgets/common_widgets.dart';

class AddLoyaltyCard extends StatefulWidget {
  ModelLoayltyCard modelLoayltyCard;
  bool? isEditing;
  String? docId;
  AddLoyaltyCard(
      {super.key, required this.modelLoayltyCard, this.isEditing, this.docId});

  @override
  State<AddLoyaltyCard> createState() => _AddLoyaltyCardState();
}

class _AddLoyaltyCardState extends State<AddLoyaltyCard> {
  File? frontImg, backImg;
  final StorageService _storageService = StorageService();
  final DatabaseService _databaseService = DatabaseService();
  bool isEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.darkGrey,
        title: const SizedBox(
          child: Text(StringManager.addLoyaltyCardAppbarTittle,
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(33),
            child: Text(
              StringManager.addLoyaltyCardContent,
              textAlign: TextAlign.center,
              style: getRegularStyle(
                  color: ColorManager.darkGrey, fontSize: FontSize.s14),
            ),
          ),
          ImageSection(
            isEnable: isEnable,
            backURL: widget.modelLoayltyCard.cardBackURL,
            frontURL: widget.modelLoayltyCard.cardFrontURL,
            backImgSelect: (p0) {
              setState(() {
                backImg = p0;
              });
            },
            frontImgSelect: (p0) {
              setState(() {
                frontImg = p0;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          FormSection(
            modelLoayltyCard: widget.modelLoayltyCard,
            onSaveForm: (p0) async {
              setState(() {
                isEnable = false;
              });
              widget.isEditing != null
                  ? await updateInfo(p0)
                  : await saveInfo(p0);
              setState(() {
                isEnable = true;
              });
            },
          ),
        ]),
      ),
    );
  }

  saveInfo(ModelLoayltyCard p0) async {
    if (frontImg != null && backImg != null) {
      final url = await _storageService.saveImages(frontImg!, backImg!);
      _databaseService.saveCardDetails(
          onError: (error) {
            CommonWidgets.showSnakbar(context, error);
          },
          onSuccess: () {
            CommonWidgets.showSnakbar(
                context, StringManager.loyaltyCardAddedmessage);
          },
          cardName: p0.cardName!,
          vendor: p0.vendor!,
          programmeName: p0.programmeName!,
          webURL: p0.webURL!,
          note: p0.note!,
          cardFrontURL: url[0],
          cardBackURL: url[1]);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoyaltyCards()));
    } else {
      CommonWidgets.showSnakbar(context, StringManager.cardImagerequireMessage);
    }
  }

  updateInfo(ModelLoayltyCard p0) async {
    if (frontImg != null && backImg != null) {
      final url = await _storageService.saveImages(frontImg!, backImg!);
      setState(() {
        widget.modelLoayltyCard.cardBackURL = url[1];
        widget.modelLoayltyCard.cardFrontURL = url[0];
      });
    }
    await _databaseService.updateCardDetails(
      backURL: widget.modelLoayltyCard.cardBackURL!,
      frontURL: widget.modelLoayltyCard.cardFrontURL!,
      docId: widget.docId!,
      modelLoayltyCard: p0,
    );
    CommonWidgets.showSnakbar(
        context, StringManager.loyaltyCardDataUpdationMessage);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoyaltyCards()));
  }
}
