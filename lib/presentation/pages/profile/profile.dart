import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/styles/colors.dart';
import 'package:ngawasi/styles/text_styles.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile_page';
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kDeepBlue),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        elevation: 0.5,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.account_balance),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: buildName(),
          ),
          // const SizedBox(height: 24),
          // const SizedBox(height: 48),
          // buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'name :',
          //   style: kTextTheme.subtitle1,
          // ),
          // Text(
          //   firebaseUser!.displayName!,
          //   style: kTextTheme.headline6,
          // ),
          // SizedBox(height: 15),
          Text(
            'email :',
            style: kTextTheme.subtitle1,
          ),
          Text(
            firebaseUser!.email!,
            style: kTextTheme.headline6,
          ),
        ],
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // ignore: prefer_const_constructors
            Text(
              'about',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
