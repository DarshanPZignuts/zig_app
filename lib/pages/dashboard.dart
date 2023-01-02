import 'package:flutter/material.dart';
// ignore: implementation_imports

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 2;

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
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            accountEmail: Text("darshanvano009@gmail.com"),
            accountName: Text("Darshan Vanol"),
          ),
          ListTile(
            title: Text("Payments"),
            trailing: Icon(Icons.payment),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Colors.grey.shade500),
          ListTile(
            title: Text("Change Password"),
            trailing: Icon(Icons.password),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Colors.grey.shade500),
          ListTile(
            title: Text("Address"),
            trailing: Icon(Icons.house_siding_sharp),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Colors.grey.shade500),
          ListTile(
            title: Text("Other"),
            trailing: Icon(Icons.arrow_forward),
            style: ListTileStyle.drawer,
          ),
          Divider(color: Colors.grey.shade500),
        ],
      )),
      body: _widgetslist[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          fixedColor: Colors.amber,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.face), label: "Vendor"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 45), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
            BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
          ]),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
    );
  }
}
