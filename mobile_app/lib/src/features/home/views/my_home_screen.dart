import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/src/features/home/views/home_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../profile/views/profile_screen.dart';
import '../../report/views/report_screen.dart';
import '../../scan/views/scan_screen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  late PageController _pageController;
  int selectedIndex = 0;
  final bool _colorful = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }


  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  final List<Widget> _listOfWidget = <Widget>[
    const HomeScreen(),
    const ReportScreen(),
    const ScanScreen(),
    const ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _colorful
      //     ? SlidingClippedNavBar.colorful(
      //   backgroundColor: Colors.white,
      //   onButtonPressed: onButtonPressed,
      //   iconSize: 30,
      //   // activeColor: const Color(0xFF01579B),
      //   selectedIndex: selectedIndex,
      //   barItems: <BarItem>[
      //     BarItem(
      //       icon: Icons.home,
      //       title: 'Home',
      //       activeColor: Colors.blue,
      //       inactiveColor: Colors.orange,
      //     ),
      //     BarItem(
      //       icon: Icons.medical_information_rounded,
      //       title: 'Report',
      //       activeColor: Colors.yellow,
      //       inactiveColor: Colors.green,
      //     ),
      //     BarItem(
      //       icon: Icons.bolt_rounded,
      //       title: 'Energy',
      //       activeColor: Colors.blue,
      //       inactiveColor: Colors.red,
      //     ),
      //     BarItem(
      //       icon: Icons.account_circle,
      //       title: 'Profile',
      //       activeColor: Colors.cyan,
      //       inactiveColor: Colors.purple,
      //     ),
      //   ],
      // )
      //     : SlidingClippedNavBar(
      //   backgroundColor: Colors.white,
      //   onButtonPressed: onButtonPressed,
      //   iconSize: 25,
      //   activeColor: const Color(0xFF01579B),
      //   selectedIndex: selectedIndex,
      //   barItems: <BarItem>[
      //     BarItem(
      //       icon: FontAwesomeIcons.houseUser,
      //       title: 'Home',
      //     ),
      //     BarItem(
      //       icon: FontAwesomeIcons.flaskVial,
      //       title: 'Report',
      //     ),
      //     BarItem(
      //       icon: FontAwesomeIcons.camera,
      //       title: 'Scan',
      //     ),
      //     BarItem(
      //       icon: FontAwesomeIcons.idCardClip,
      //       title: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }

}
