// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/presentation/pages/anak_list.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/presentation/pages/profile/profile.dart';
import 'package:ngawasi/presentation/widgets/card_const_anak.dart';
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
  // ScrollController _scrollController = ScrollController();
  final CollectionReference _anak =
      FirebaseFirestore.instance.collection('anak');

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
                title: const Text('Satukan'),
                elevation: 0.5,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(
                        context,
                        ProfilePage.routeName,
                      );
                    },
                  ),
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
              body: Column(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 25.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Text(
                          'Anak',
                          style: kTextTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: StreamBuilder(
                      stream: _anak.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: streamSnapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return CardConstAnak(
                                  documentSnapshot: documentSnapshot);
                            },
                          );
                        }
                        return const Center();
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 45),
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            AnakList.routeName,
                          );
                        },
                        child: const Text('Tambah anak'),
                      ),
                    ),
                  ),
                ],
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
