import 'package:flutter/widgets.dart';
import 'package:zig_project/ui/screens/dashboard/change_password_screen.dart';
import 'package:zig_project/ui/screens/dashboard/dashboard.dart';
import 'package:zig_project/ui/screens/login/login_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/add_loyalty_card/add_loyalty_card_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_card_detail/loyalty_card_detail_screen.dart';
import 'package:zig_project/ui/screens/loyalty_card/loyalty_cards_list/loyalty_cards_screen.dart';
import 'package:zig_project/ui/screens/reset_password/reset_password_screen.dart';
import 'package:zig_project/ui/screens/signup/signin_screen.dart';
import 'package:zig_project/ui/screens/splash/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => SplashScreen(),
  LogIn.id: (context) => LogIn(),
  SignIn.id: (context) => SignIn(),
  ResetPassword.id: (context) => ResetPassword(),
  ChangePassword.id: (context) => ChangePassword(),
  AddLoyaltyCard.id: (context) => AddLoyaltyCard(),
  LoyaltyCardDetail.id: (context) => LoyaltyCardDetail(),
  LoyaltyCards.id: (context) => LoyaltyCards(),
  Dashboard.id: (context) => Dashboard()
};
