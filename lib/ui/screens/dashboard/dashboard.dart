import 'package:flutter/material.dart';
import 'package:zig_project/ui/screens/categories/categories_screen.dart';
import 'package:zig_project/ui/screens/dashboard/artical_list_screen/article_list_screen.dart';
import 'package:zig_project/ui/screens/dashboard/home_screen/home_screen.dart';

import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/ui/screens/dashboard/random_user_screen/random_user_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';

// ignore: implementation_imports

class Dashboard extends StatefulWidget {
  static const String id = "Dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 2;

  final List<Widget> _widgetslist = [
    const HomeScreen(),
    RandomUserScreen(),
    ArticalList(),
    const Categories(),
    const LoyaltyCards()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          selectedIconTheme: const IconThemeData(size: 35),
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
    );
  }
}
