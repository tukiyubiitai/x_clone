import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Colors.blue,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    Text("Feed Screen"),
    Text("Search Screen"),
    Text("Person Screen"),
    Text("Notifier Screen"),
    Text("Message Screen"),
  ];
}
