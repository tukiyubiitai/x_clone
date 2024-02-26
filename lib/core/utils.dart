import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  print(content);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) {
  //　test@gmail.com
  // List = [test,@gmail.com]
  return email.split("@")[0];
}
