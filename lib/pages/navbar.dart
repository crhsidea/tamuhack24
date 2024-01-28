import 'package:flacktest/pages/navscreens/applications.dart';
import 'package:flacktest/pages/navscreens/home.dart';
import 'package:flacktest/pages/navscreens/listing.dart';
import 'package:flacktest/pages/navscreens/profile.dart';
import 'package:flacktest/pages/navscreens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreenNav extends StatefulWidget {
  const MainScreenNav({super.key});

  @override
  State<MainScreenNav> createState() => _MainScreenNavState();
}

class _MainScreenNavState extends State<MainScreenNav> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
			resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: const Color(0xFF065A82),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomePage(),
    ApplicationsPage(),
    ListingsPage(),
    ProfilePage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Color(0xFF91A6FF),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.edit),
      title: ("Apps"),
      activeColorPrimary: Color(0xFF91A6FF),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.checklist),
      title: ("Listings"),
      activeColorPrimary: Color(0xFF91A6FF),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.account_circle),
      title: ("Profile"),
      activeColorPrimary: Color(0xFF91A6FF),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
