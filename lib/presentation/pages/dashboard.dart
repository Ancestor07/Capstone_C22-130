// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/presentation/pages/anak_list.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/services/firebase_service.dart';
import 'package:ngawasi/styles/colors.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseService service = FirebaseService();
  // User? user = FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user != null) {

  //   }
  //  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kCreamyOrange),
    );
    return StreamBuilder(
      stream: service.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Dashboard'),
                elevation: 0.5,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      FirebaseService service = FirebaseService();
                      await service.signOutFromGoogle();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Login.routeName,
                        (Route<dynamic> route) => false,
                      );
                    },
                  )
                ],
              ),
              body: const SafeArea(
                child: AnakList(),
              ));
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
