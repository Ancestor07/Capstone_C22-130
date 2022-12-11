import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile_page';
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: const [
          Text(
            'name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            'email',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )
        ],
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // ignore: prefer_const_constructors
            Text(
              'about',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
