import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/model/model_loyalty_card.dart';

import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/value_manager.dart';
import 'package:zig_project/services/database_service.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/loyalty_card/utilities/custom_card.dart';
import 'package:zig_project/ui/screens/loyalty_card/utilities/empty_card.dart';

class LoyaltyCards extends StatefulWidget {
  const LoyaltyCards({super.key});

  @override
  State<LoyaltyCards> createState() => _LoyaltyCardsState();
}

class _LoyaltyCardsState extends State<LoyaltyCards> {
  bool isShowOptions = false;
  final DatabaseService _databaseService = DatabaseService();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? listOfcards = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.darkGrey,
        leading: InkWell(
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => const Dashboard()))),
          child: const Padding(
            padding:
                EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p14),
            child: Icon(Icons.arrow_back),
          ),
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
              if (snapshot.data!.docs.isNotEmpty) {
                return GridView.builder(
                    itemCount: (snapshot.data?.size)! + 1 ?? 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 150,
                    ),
                    itemBuilder: ((context, index) {
                      if (snapshot.hasData) {
                        if (index == snapshot.data!.docs.length) {
                          return const EmptyCard();
                        } else {
                          DocumentSnapshot docSnap =
                              snapshot.data!.docs.elementAt(index);

                          if (index % 3 == 1) {
                            return CustomCard(
                              loayltyCard: ModelLoayltyCard(
                                  docId: docSnap.id,
                                  cardBackURL: docSnap["cardBackURL"],
                                  cardFrontURL: docSnap["cardFrontURL"],
                                  cardName: docSnap["cardName"],
                                  programmeName: docSnap["programmeName"],
                                  vendor: docSnap["vendor"],
                                  webURL: docSnap["webURL"],
                                  note: docSnap["note"]),
                              tittle: docSnap["cardName"],
                              subTittle: docSnap["programmeName"],
                              bgColor: ColorManager.cardBackground1,
                              circleBgColor: ColorManager.cAvatarBackground1,
                            );
                          } else if (index % 3 == 2) {
                            return CustomCard(
                              loayltyCard: ModelLoayltyCard(
                                note: docSnap["note"],
                                docId: docSnap.id,
                                cardBackURL: docSnap["cardBackURL"],
                                cardFrontURL: docSnap["cardFrontURL"],
                                cardName: docSnap["cardName"],
                                programmeName: docSnap["programmeName"],
                                vendor: docSnap["vendor"],
                                webURL: docSnap["webURL"],
                              ),
                              tittle: docSnap["cardName"],
                              subTittle: docSnap["programmeName"],
                              bgColor: ColorManager.cardBackground2,
                              circleBgColor: ColorManager.cAvatarBackground2,
                            );
                          } else {
                            return CustomCard(
                              loayltyCard: ModelLoayltyCard(
                                note: docSnap["note"],
                                docId: docSnap.id,
                                cardBackURL: docSnap["cardBackURL"],
                                cardFrontURL: docSnap["cardFrontURL"],
                                cardName: docSnap["cardName"],
                                programmeName: docSnap["programmeName"],
                                vendor: docSnap["vendor"],
                                webURL: docSnap["webURL"],
                              ),
                              circleBgColor: ColorManager.cAvatarBackground,
                              bgColor: ColorManager.cardBackground,
                              tittle: docSnap["cardName"],
                              subTittle: docSnap["programmeName"],
                            );
                          }
                        }
                      } else {
                        return const EmptyCard();
                      }
                    }));
              } else {
                return GridView.builder(
                    itemCount: 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 150,
                    ),
                    itemBuilder: ((context, index) {
                      return const EmptyCard();
                    }));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }
          },
        ),
      ),
    );
  }
}
