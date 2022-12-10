import 'package:flutter/material.dart';
import 'package:ngawasi/styles/colors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      keyboardType: TextInputType.text,
      obscureText: !_passwordVisible,
      enableSuggestions: false,
      autocorrect: false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: kRipeOrange)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kDeepBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kDeepBlue),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Enter a password!';
        }
        return null;
      },
    );
  }
}
