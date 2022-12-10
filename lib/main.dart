import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/common/utils.dart';
import 'package:ngawasi/firebase_options.dart';
import 'package:ngawasi/presentation/pages/dashboard.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/presentation/pages/entry/get_started.dart';
import 'package:ngawasi/styles/colors.dart';
import 'package:ngawasi/styles/text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: isLoggedIn ? const Dashboard() : const GetStarted(),
      // home: const HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Login.routeName:
            return MaterialPageRoute(builder: (_) => const Login());
          case GetStarted.routeName:
            return MaterialPageRoute(builder: (_) => const GetStarted());
          case Dashboard.routeName:
            return MaterialPageRoute(builder: (_) => const Dashboard());
          default:
            return MaterialPageRoute(builder: (_) => const Login());
        }
      },
    );
  }
}
