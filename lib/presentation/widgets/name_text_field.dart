import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController namaController;

  const NameTextField({
    super.key,
    required this.namaController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: namaController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Email',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kRipeOrange),
        ),
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
          return 'Enter a valid name!';
        }
        return null;
      },
    );
  }
}
