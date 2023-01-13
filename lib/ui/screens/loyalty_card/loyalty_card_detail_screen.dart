import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/resources/value_manager.dart';

class LoyaltyCardDetail extends StatefulWidget {
  final String tittle;
  const LoyaltyCardDetail({super.key, required this.tittle});

  @override
  State<LoyaltyCardDetail> createState() => _LoyaltyCardDetailState();
}

class _LoyaltyCardDetailState extends State<LoyaltyCardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.darkGrey,
        // leading: const Padding(
        //   padding: EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p14),
        //   child: Icon(Icons.arrow_back),
        // ),

        title: const SizedBox(
          child: Text("Card Details",
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
      ),
      body: Column(children: [
        _customCard(tittle: widget.tittle),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Lorem Ipsum",
                  style: getBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.black,
                  )),
            ),
            Row(
              children: [
                Text("Member ID : ",
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14)),
                Text("JHG7576487969667476",
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.s12))
              ],
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Icon(Icons.blur_circular),
              SizedBox(
                width: 4,
              ),
              Text(widget.tittle,
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s14))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
              "mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium"),
        )
      ]),
    );
  }
}

class _customCard extends StatefulWidget {
  final String tittle;

  _customCard({
    Key? key,
    required this.tittle,
  }) : super(key: key);

  @override
  State<_customCard> createState() => _customCardState();
}

class _customCardState extends State<_customCard> {
  bool showOption = false;

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
                                widget.tittle.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontSize: 33,
                                    fontWeight: FontWeightManager.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  this.widget.tittle,
                                  style: getBoldStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text("Loyalty Programme",
                                    style: TextStyle(
                                        color: ColorManager.darkGrey,
                                        fontSize: 12,
                                        letterSpacing: 0.2)),
                              ],
                            ),
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
