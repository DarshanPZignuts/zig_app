import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/authentication/auth.dart';
import 'package:zig_project/pages/Other/dialog_box.dart';
import 'package:zig_project/pages/change_password.dart';
import 'package:zig_project/pages/login.dart';
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
      child: Text("This is Categories Page"),
    ),
    Center(
      child: Text("This is Vendors Page"),
    ),
    Center(
      child: Text("This is Home Pages"),
    ),
    Center(
      child: Text("This is  List Page"),
    ),
    Center(
      child: Text("This is More Page"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(
                  currentUser!.displayName!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.amber, Colors.amberAccent])),
              accountEmail: Text(currentUser!.email ?? "not found"),
              accountName: Text(currentUser!.displayName ?? "not found"),
            ),
            const ListTile(
              title: Text("Payments"),
              leading: Icon(Icons.payment),
              style: ListTileStyle.drawer,
            ),
            ListTile(
              title: const Text("Change Password"),
              leading: const Icon(Icons.password),
              style: ListTileStyle.drawer,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
            const ListTile(
              title: Text("Address"),
              leading: Icon(Icons.apartment),
              style: ListTileStyle.drawer,
            ),
            const ListTile(
              title: Text("Other"),
              leading: Icon(Icons.more_horiz),
              style: ListTileStyle.drawer,
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: (context),
                    builder: ((context) => DialogBox().dialogBox(context)));
              },
              title: const Text("Signout"),
              leading: const Icon(Icons.logout),
              style: ListTileStyle.drawer,
            ),
          ],
        )),
      ),
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
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 35),
          fixedColor: Colors.amber,
          iconSize: 25,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Vendor"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), label: "More"),
          ]),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
    );
  }
}
