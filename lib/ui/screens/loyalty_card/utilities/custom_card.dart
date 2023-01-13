import 'package:flutter/material.dart';
import 'package:zig_project/model/app_user.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/utilities/custom_option_bar.dart';

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
                                  tittle: widget.tittle,
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
                          style: TextStyle(
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
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (showOption) {
                                showOption = false;
                              } else {
                                showOption = true;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Icon(Icons.more_vert),
                          )),
                      showOption
                          ? CustomOptionBar(
                              modelLoayltyCard: widget.loayltyCard,
                            )
                          : SizedBox(),
                    ],
                  ),

                  //
                ),
              ]),
              Container(
                child: Column(
                  children: [
                    Text(
                      this.widget.tittle,
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s14),
                    ),
                    Text(widget.subTittle,
                        style: TextStyle(
                            color: ColorManager.darkGrey,
                            fontSize: 10,
                            letterSpacing: 0.2)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
