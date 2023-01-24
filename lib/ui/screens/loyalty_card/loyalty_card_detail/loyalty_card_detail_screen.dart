import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/fonts_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/resources/style_manager.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail/custom_detail_card.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail/loyalty_card_detail_screen_arguments.dart';

class LoyaltyCardDetail extends StatefulWidget {
  static const String id = "LoyaltyCardDetail";

  LoyaltyCardDetail({super.key});

  @override
  State<LoyaltyCardDetail> createState() => _LoyaltyCardDetailState();
}

class _LoyaltyCardDetailState extends State<LoyaltyCardDetail> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as LoyaltyCardDetailScreenArguments;
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
          child: Text(StringManager.cardDetailAppbarText,
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w800)),
        ),
      ),
      body: Column(children: [
        DetailCard(modelLoayltyCard: args.modelLoayltyCard),
        Container(
          padding: const EdgeInsets.all(20),
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
                Text(StringManager.memberIdTittleText,
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
              const Icon(Icons.blur_circular),
              const SizedBox(
                width: 4,
              ),
              Text(args.modelLoayltyCard.cardName!,
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s14))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
              "mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium"),
        )
      ]),
    );
  }
}
