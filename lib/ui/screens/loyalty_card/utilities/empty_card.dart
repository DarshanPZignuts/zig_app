import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/add_loyalty_card_screen.dart';

class EmptyCard extends StatefulWidget {
  const EmptyCard({super.key});

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                color: ColorManager.grey,
                strokeWidth: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AddLoyaltyCard(
                                  modelLoayltyCard: ModelLoayltyCard(
                                      cardBackURL: "",
                                      cardFrontURL: "",
                                      cardName: "",
                                      programmeName: "",
                                      vendor: "",
                                      webURL: ""),
                                ))));
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: double.infinity,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.grey.shade600,
                    )),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
