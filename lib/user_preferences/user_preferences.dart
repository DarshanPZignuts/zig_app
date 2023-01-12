import 'package:shared_preferences/shared_preferences.dart';
import 'package:zig_project/model/app_user.dart';

const String id = "id";
const String name = "name";
const String email = "email";
const String isSignin = "isSignin";

class UserPreferences {
  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? "";
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(email) ?? "";
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name) ?? "";
  }

  Future<bool> getUserSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isSignin) ?? false;
  }

  Future<void> setUserId({required String userId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, userId);
  }

  Future<void> setUserName({required String userName}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, userName);
  }

  Future<void> setUserEmail({required String userEmail}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(email, userEmail);
  }

  Future<void> setIsSignIn({required bool isSignIn}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isSignin, isSignIn);
  }

  static Future<void> saveLoginUserInfo(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, user.uid!);
    await prefs.setString(name, user.name!);
    await prefs.setString(email, user.email!);
    await prefs.setBool(isSignin, true);
  }

  static Future<AppUser> getLoginUserInfo(AppUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId = await prefs.getString(id);
    String? uName = await prefs.getString(name);
    String? uEmail = await prefs.getString(email);
    AppUser user = AppUser(email: uEmail, name: uName, uid: uId);
    return user;
  }

  static Future<void> clearDetailsOnSignOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isSignin, false);
    await prefs.setString(id, "");
    await prefs.setString(name, "");
    await prefs.setString(email, "");
  }
}
