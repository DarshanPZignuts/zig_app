import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/resources/value_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail.dart';

class LoyaltyCards extends StatefulWidget {
  const LoyaltyCards({super.key});

  @override
  State<LoyaltyCards> createState() => _LoyaltyCardsState();
}

class _LoyaltyCardsState extends State<LoyaltyCards> {
  DatabaseService _databaseService = DatabaseService();
  List list = ["House of fraser", "Nactar"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.darkGrey,
        leading: const Padding(
          padding: EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p14),
          child: Icon(Icons.arrow_back),
        ),
        leadingWidth: 40,
        title: const SizedBox(
          child: Text("Loyalty Cards",
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
        actions: const [
          Padding(
            padding:
                EdgeInsets.only(right: AppPadding.p10, left: AppPadding.p10),
            child: Icon(Icons.search),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: AppPadding.p20, left: AppPadding.p10),
            child: Icon(Icons.qr_code),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: StreamBuilder(
          stream: _databaseService.getStreamOfLoyaltyCards(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              list = snapshot.data?.get("loyaltyCards");
              return GridView.builder(
                  itemCount: list.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: ((context, index) {
                    if (index == list.length) {
                      return const _emptyCard();
                    }
                    return _customCard(
                      tittle: list[index]["cardName"],
                      subTittle: list[index]["programmeName"],
                    );
                  }));
            } else {
              return Text("Loading");
            }
          },
        ),
        // child: GridView.builder(
        //     itemCount: list.length + 1,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisSpacing: 10,
        //       crossAxisCount: 2,
        //       mainAxisSpacing: 10,
        //       mainAxisExtent: 150,
        //     ),
        //     itemBuilder: ((context, index) {
        //       if (index == list.length) {
        //         return const _emptyCard();
        //       }
        //       return _customCard(
        //         tittle: list[index],
        //       );
        //     })),
      ),
    );
  }
}

class _emptyCard extends StatefulWidget {
  const _emptyCard({super.key});

  @override
  State<_emptyCard> createState() => __emptyCardState();
}

class __emptyCardState extends State<_emptyCard> {
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
                            builder: ((context) => AddLoyaltyCard())));
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

class _customCard extends StatefulWidget {
  final String tittle;
  final String subTittle;

  _customCard({
    Key? key,
    required this.tittle,
    required this.subTittle,
  }) : super(key: key);

  @override
  State<_customCard> createState() => _customCardState();
}

class _customCardState extends State<_customCard> {
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
                        color: ColorManager.cardBackground,
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: ColorManager.cAvatarBackground,
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
                      showOption ? _customOptionCard() : SizedBox(),
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

class _customOptionCard extends StatelessWidget {
  const _customOptionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
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
                  // Navigate to Edit
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: ColorManager.primary, fontSize: FontSize.s12),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
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
