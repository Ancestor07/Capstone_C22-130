import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:ngawasi/presentation/pages/dashboard.dart';
import 'package:ngawasi/presentation/widgets/show_message.dart';
import 'package:ngawasi/services/firebase_service.dart';

class GoogleSignInButton extends StatelessWidget {
  final String text;
  const GoogleSignInButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      text: text,
      onPressed: () async {
        FirebaseService service = FirebaseService();
        try {
          if (kIsWeb) {
            await service.signInWithGoogleWebsite();
          }
          await service.signInWithGoogle();
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            Dashboard.routeName,
            (Route<dynamic> route) => false,
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            ShowMessage(
              message: e.message!,
            );
          }
        }
      },
    );
  }
}
