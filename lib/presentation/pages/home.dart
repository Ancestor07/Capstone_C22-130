import 'package:flutter/material.dart';
import 'package:ngawasi/presentation/pages/getstarted/get_started_1.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngawasi'),
      ),
      body: const GetStarted1(),
    );
  }
}
