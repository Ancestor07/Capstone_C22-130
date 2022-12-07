import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/common/utils.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/presentation/pages/entry/get_started.dart';
import 'package:ngawasi/presentation/pages/home.dart';
import 'package:ngawasi/styles/colors.dart';
import 'package:ngawasi/styles/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ngawasi',
      theme: ThemeData(
        colorScheme: kColorScheme,
        primaryColor: kCreamyOrange,
        scaffoldBackgroundColor: kSoftWhite,
        textTheme: kTextTheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      navigatorObservers: [routeObserver],
      home: const HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Login.routeName:
            return MaterialPageRoute(builder: (_) => const Login());
          case GetStarted.routeName:
            return MaterialPageRoute(builder: (_) => const GetStarted());
          default:
            return MaterialPageRoute(builder: (_) => const Login());
        }
      },
    );
  }
}
