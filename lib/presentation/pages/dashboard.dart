// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/presentation/pages/anak_list.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/services/firebase_service.dart';
import 'package:ngawasi/styles/colors.dart';
import 'package:ngawasi/styles/text_styles.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseService service = FirebaseService();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kDeepBlue),
    );

    return StreamBuilder(
      stream: service.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Ngawasi'),
                elevation: 0.5,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      service = FirebaseService();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Login.routeName,
                        (Route<dynamic> route) => false,
                      );
                      await service.signOutFromGoogle();
                    },
                  )
                ],
              ),
              body: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      color: kCreamyOrange,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 15.0,
                          bottom: 30.0,
                          right: 15.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, ${snapshot.data!.email!}!',
                              style: kTextTheme.subtitle1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Semoga harimu baik!',
                              style: kTextTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Anak',
                        style: kTextTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
