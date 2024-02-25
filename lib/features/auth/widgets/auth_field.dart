import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Pallete.blueColor, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Pallete.greyColor,
            ),
          ),
          contentPadding: EdgeInsets.all(22),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
          )),
    );
  }
}
