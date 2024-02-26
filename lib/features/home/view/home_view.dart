import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x_clone/constants/constants.dart';
import 'package:x_clone/theme/pallete.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => HomeView());

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
              icon: _page == 1
                  ? Icon(
                      Icons.search,
                      color: Pallete.whiteColor,
                    )
                  : Icon(Icons.search_outlined)),
          BottomNavigationBarItem(
            icon: _page == 2
                ? Icon(
                    Icons.group,
                    color: Pallete.whiteColor,
                  )
                : Icon(Icons.group_outlined),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 3
                  ? AssetsConstants.notifFilledIcon
                  : AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
              icon: _page == 4
                  ? Icon(
                      Icons.mail,
                      color: Pallete.whiteColor,
                    )
                  : Icon(
                      Icons.mail_outline,
                    )),
        ],
      ),
    );
  }
}
