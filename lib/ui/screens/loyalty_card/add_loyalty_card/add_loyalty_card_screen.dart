import 'dart:io';
import 'package:flutter/material.dart';

import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/services/storage_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_arguments.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/card_image_section.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/form_section.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';

import 'package:zig_project/ui/widgets/widgets.dart';

class AddLoyaltyCard extends StatefulWidget {
  static const String id = "AddLoyaltyCard";

  AddLoyaltyCard({super.key});

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
    final args =
        ModalRoute.of(context)!.settings.arguments as LoyaltyCardArguments;
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
            backURL: args.modelLoayltyCard.cardBackURL,
            frontURL: args.modelLoayltyCard.cardFrontURL,
            backImgSelect: (backImageFile) {
              setState(() {
                backImg = backImageFile;
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
            modelLoayltyCard: args.modelLoayltyCard,
            onSaveForm: (modelLoyalty) async {
              setState(() {
                isEnable = false;
              });
              args.isEditing != null
                  ? await updateInfo(modelLoyalty, args)
                  : await saveInfo(modelLoyalty, args);
              setState(() {
                isEnable = true;
              });
            },
          ),
        ]),
      ),
    );
  }

  Future<void> saveInfo(
      ModelLoayltyCard modelLoyalty, LoyaltyCardArguments args) async {
    if (frontImg != null && backImg != null) {
      final url = await _storageService.saveImages(frontImg!, backImg!);
      _databaseService.saveCardDetails(
          onError: (error) {
            CommonWidgets.showSnakbar(context, error);
          },
          onSuccess: () {
            CommonWidgets.showSnakbar(
                context, StringManager.loyaltyCardAddedmessage);
            Navigator.of(context).pushReplacementNamed(LoyaltyCards.id);
          },
          cardName: modelLoyalty.cardName!,
          vendor: modelLoyalty.vendor!,
          programmeName: modelLoyalty.programmeName!,
          webURL: modelLoyalty.webURL!,
          note: modelLoyalty.note!,
          cardFrontURL: url[0],
          cardBackURL: url[1]);
    } else {
      CommonWidgets.showSnakbar(context, StringManager.cardImagerequireMessage);
    }
  }

  Future<void> updateInfo(
      ModelLoayltyCard modelLoyalty, LoyaltyCardArguments args) async {
    if (frontImg != null && backImg != null) {
      final url = await _storageService.saveImages(frontImg!, backImg!);
      setState(() {
        args.modelLoayltyCard.cardBackURL = url[1];
        args.modelLoayltyCard.cardFrontURL = url[0];
      });
    }
    await _databaseService.updateCardDetails(
      onError: (String error) {
        CommonWidgets.showSnakbar(context, error);
      },
      onSuccess: () {
        CommonWidgets.showSnakbar(
            context, StringManager.loyaltyCardDataUpdationMessage);
        Navigator.of(context).pushReplacementNamed(LoyaltyCards.id);
      },
      backURL: args.modelLoayltyCard.cardBackURL!,
      frontURL: args.modelLoayltyCard.cardFrontURL!,
      docId: args.docId!,
      modelLoayltyCard: modelLoyalty,
    );
  }
}
