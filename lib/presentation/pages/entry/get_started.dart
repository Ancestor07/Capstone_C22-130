import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:ngawasi/presentation/pages/entry/login.dart';
import 'package:ngawasi/styles/colors.dart';

class GetStarted extends StatefulWidget {
  static const routeName = '/get-started';
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with TickerProviderStateMixin {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Login.routeName,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kCreamyOrange),
    );

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: 'Bimbing anak',
            body: 'Membimbing anak dengan baik dan benar dengan mudah',
            image: Lottie.asset(
              'assets/51107-parenting.json',
              width: 400.0,
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Laporan belajar',
            body: 'Dapatkan laporan belajar dari guru sekolah anak',
            image: Lottie.asset(
              'assets/73850-offline-teaching.json',
              width: 400.0,
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Monitor anak',
            body: 'Awasi anak dengan mudah dimanapun dia berada',
            image: Lottie.asset(
              'assets/106486-woman-tracking-on-phone.json',
              width: 400.0,
            ),
            decoration: pageDecoration,
          )
        ],
        onDone: () => _onIntroEnd(context),
        showBackButton: false,
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        back: const Icon(Icons.arrow_back),
        next: const Icon(Icons.arrow_forward),
        skip: const Text('Lewati'),
        done: const Text('Selesai'),
      ),
    );
  }
}
