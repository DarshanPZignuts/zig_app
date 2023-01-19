import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zig_project/model/app_user.dart';
import 'package:zig_project/resources/colors_manager.dart';
import 'package:zig_project/resources/string_manager.dart';
import 'package:zig_project/services/authentication/auth.dart';
import 'package:zig_project/ui/dialogs/dialog_box.dart';
import 'package:zig_project/ui/screens/dashboard/change_password_screen.dart';
import 'package:zig_project/ui/screens/dashboard/test.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/user_preferences/user_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUser? _appUser;
  getUserInfo() async {
    _appUser = await UserPreferences.getLoginUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.primary,
        elevation: 0,
      ),
      drawer: SafeArea(
        child: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _appUser?.name?.substring(0, 1).toUpperCase() ?? "N",
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(color: ColorManager.secondary),
              accountEmail:
                  Text(_appUser?.email ?? StringManager.dashboardEmailError),
              accountName:
                  Text(_appUser?.name ?? StringManager.dashboardNameError),
            ),
            const ListTile(
              title: Text(StringManager.dashboardListTilePayments),
              leading: Icon(Icons.payment),
              style: ListTileStyle.drawer,
            ),
            ListTile(
              title: const Text(StringManager.dashboardListTileChangePassword),
              leading: const Icon(Icons.password),
              style: ListTileStyle.drawer,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePassword()));
              },
            ),
            const ListTile(
              title: Text(StringManager.dashboardListTileAddress),
              leading: Icon(Icons.apartment),
              style: ListTileStyle.drawer,
            ),
            const ListTile(
              title: Text(StringManager.dashboardListTileOther),
              leading: Icon(Icons.more_horiz),
              style: ListTileStyle.drawer,
            ),
            ListTile(
              title: Text(StringManager.dashboardListTileOther),
              leading: Icon(Icons.more_horiz),
              style: ListTileStyle.drawer,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Test(),
              )),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    context: (context),
                    builder: ((context) => DialogBox.dialogBox(
                        context: context,
                        content: StringManager.alertBoxDescription,
                        onYes: () async {
                          if (FirebaseAuth.instance.currentUser != null) {
                            await _auth.signOut();
                          }
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const LogIn())),
                              (route) => false);
                        },
                        tittle: StringManager.alertBoxTittle)));
              },
              title: const Text(
                StringManager.dashboardListTileSignOut,
                style: TextStyle(color: Colors.redAccent),
              ),
              leading: const Icon(Icons.logout),
              style: ListTileStyle.drawer,
            ),
          ],
        )),
      ),
    );
  }
}
