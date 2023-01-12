import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/dialogs/dialog_box.dart';
import 'package:zig_project/ui/screens/dashboard/change_password.dart';
import 'package:zig_project/ui/screens/categories/categories_screen.dart';

import 'package:zig_project/ui/screens/login/login.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';

import '../loyalty_card/Loyalty_cards.dart';
// ignore: implementation_imports

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Auth _auth = Auth();
  int currentIndex = 2;
  User? currentUser = null;

  @override
  void initState() {
    currentUser = _auth.getUser();
    // TODO: implement initState
    super.initState();
  }

  static const List<Widget> _widgetslist = [
    Center(
      child: Text(StringManager.homePageContent),
    ),
    Center(
      child: Text(StringManager.vendorPageContent),
    ),
    Center(
      child: Text(StringManager.listPageContent),
    ),
    Categories(),
    LoyaltyCards()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  drawer: SafeArea(
      //   child: Drawer(
      //       child: ListView(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: CircleAvatar(
      //           child: Text(
      //             currentUser!.displayName!.substring(0, 1).toUpperCase(),
      //             style: TextStyle(
      //                 color: ColorManager.primary,
      //                 fontSize: 28,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //           backgroundColor: Colors.white,
      //         ),
      //         decoration: BoxDecoration(color: ColorManager.primary),
      //         accountEmail:
      //             Text(currentUser!.email ?? StringManager.dashboardEmailError),
      //         accountName: Text(
      //             currentUser!.displayName ?? StringManager.dashboardNameError),
      //       ),
      //       const ListTile(
      //         title: Text(StringManager.dashboardListTilePayments),
      //         leading: Icon(Icons.payment),
      //         style: ListTileStyle.drawer,
      //       ),
      //       ListTile(
      //         title: const Text(StringManager.dashboardListTileChangePassword),
      //         leading: const Icon(Icons.password),
      //         style: ListTileStyle.drawer,
      //         onTap: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => ChangePassword()));
      //         },
      //       ),
      //       const ListTile(
      //         title: Text(StringManager.dashboardListTileAddress),
      //         leading: Icon(Icons.apartment),
      //         style: ListTileStyle.drawer,
      //       ),
      //       const ListTile(
      //         title: Text(StringManager.dashboardListTileOther),
      //         leading: Icon(Icons.more_horiz),
      //         style: ListTileStyle.drawer,
      //       ),
      //       ListTile(
      //         onTap: () async {
      //           showDialog(
      //               context: (context),
      //               builder: ((context) => DialogBox().dialogBox(context)));
      //         },
      //         title: const Text(
      //           StringManager.dashboardListTileSignOut,
      //           style: TextStyle(color: Colors.redAccent),
      //         ),
      //         leading: const Icon(Icons.logout),
      //         style: ListTileStyle.drawer,
      //       ),
      //     ],
      //   )),
      // ),
      body: _widgetslist[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedItemColor: ColorManager.primary,
          selectedIconTheme: IconThemeData(size: 35),
          fixedColor: ColorManager.secondary,
          iconSize: 25,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              label: StringManager.dashboardBottomNavHome,
              icon: Icon(
                Icons.home,
              ),
            ),

            //Vendor
            BottomNavigationBarItem(
              label: StringManager.dashboardBottomNavVendors,
              icon: Icon(Icons.people),
            ),
            //Home

            //label: "List"
            BottomNavigationBarItem(
              label: StringManager.dashboardBottomNavList,
              icon: Icon(Icons.list),
            ),
            //Categories
            BottomNavigationBarItem(
              label: StringManager.dashboardBottomNavCategory,
              icon: Icon(Icons.category),
            ),

            //label: "More"

            BottomNavigationBarItem(
              label: StringManager.dashboardBottomNavMore,
              icon: Icon(Icons.more_horiz),
            ),
          ]),
      // appBar: AppBar(
      //   title: const Text(StringManager.dashboardAppBarTittle),
      //   centerTitle: true,
      //   backgroundColor: ColorManager.primary,
      // ),
    );
  }
}
