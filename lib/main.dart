import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart' as prov;
import 'package:provider/provider.dart';
import 'package:zig_project/bloc/network_cubit.dart';
import 'package:zig_project/bloc/network_services.dart';
import 'package:zig_project/controller/article_controller.dart';
import 'package:zig_project/controller/local_provider.dart';
import 'package:zig_project/controller/random_user_controller.dart';
import 'package:zig_project/l10n/localization.dart';
import 'package:zig_project/resources/route_manager.dart';
import 'package:zig_project/ui/screens/splash/splash_screen.dart';
import 'package:zig_project/user_preferences/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale; // Local to set the local language to the application

  @override
  void initState() {
    super.initState();
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            LocaleProvider().setLocale(locale = Locale(value));
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var networkService = NetworkService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(
          create: (context) =>
              NetworkCubit(networkService: networkService, context: context),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<RandomUserController>(
              create: (_) => RandomUserController()),
          ChangeNotifierProvider<ArticleController>(
              create: (_) => ArticleController()),
        ],
        child: prov.ChangeNotifierProvider(
          create: (_) => LocaleProvider(),
          child: prov.Consumer<LocaleProvider>(
            builder: (context, value, child) {
              return MaterialApp(
                locale: value.locale ?? locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: L10n.all,
                routes: routes,
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
