import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class GetStarted1 extends StatefulWidget {
  const GetStarted1({super.key});

  @override
  State<GetStarted1> createState() => _GetStarted1State();
}

class _GetStarted1State extends State<GetStarted1>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Lottie.asset(
          'assets/51107-parenting.json',
          width: 400.0,
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
        const Text('Bimbing anak dengan baik dan benar'),
      ],
    );
  }
}
