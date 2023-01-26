// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngawasi/presentation/pages/dashboard.dart';
import 'package:ngawasi/presentation/pages/entry/register.dart';
import 'package:ngawasi/presentation/widgets/email_text_field.dart';
import 'package:ngawasi/presentation/widgets/google_sign_in_button.dart';
import 'package:ngawasi/presentation/widgets/password_text_field.dart';
import 'package:ngawasi/services/firebase_service.dart';
import 'package:ngawasi/styles/colors.dart';
import 'package:ngawasi/styles/text_styles.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kCreamyOrange),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              margin: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 75.0,
                      height: 75.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Text(
                      'Login',
                      style: kTextTheme.headline5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 35),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              width: 300.0,
                              child: EmailTextField(
                                emailController: _emailController,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Center(
                            child: SizedBox(
                              width: 300.0,
                              child: PasswordTextField(
                                passwordController: _passwordController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 45),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    FirebaseService service = FirebaseService();
                                    try {
                                      String? response = await service
                                          .signInWithEmailAndPassword(
                                        userEmail:
                                            _emailController.text.toString(),
                                        userPassword:
                                            _passwordController.text.toString(),
                                      );
                                      if (response !=
                                              'Password terlalu lemah!' &&
                                          response !=
                                              'Email sudah terdaftar!') {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Dashboard.routeName,
                                          (Route<dynamic> route) => false,
                                        );
                                      } else if (response != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(response),
                                            backgroundColor: kDeepBlue,
                                          ),
                                        );
                                        return;
                                      } else {
                                        return;
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(e.toString()),
                                        ),
                                      );
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: const Text('Login'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 300,
                            height: 45,
                            child:
                                GoogleSignInButton(text: 'Sign in with Google'),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun? '),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Register.routeName,
                            );
                          },
                          child: Text(
                            'Daftar sekarang!',
                            style: TextStyle(color: Colors.blue[500]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(
                  dismissible: false,
                  color: kDeepBlue,
                ),
              ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
