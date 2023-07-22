import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smart_irrigation_app/screens/dashboard_screen.dart';
import 'package:smart_irrigation_app/screens/signin_screen.dart';
import 'package:smart_irrigation_app/screens/Setting_screen.dart';
import 'package:smart_irrigation_app/screens/Motor_On_Off_Screen.dart';
import 'package:smart_irrigation_app/const/custom_colors.dart';
import 'package:smart_irrigation_app/screens/auto_manuak.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List pages = [
    const DashboardScreen(),
    const MotorScreen(),
    const AutoScreen(),
    // const Center(
    //   child: Text(
    //     'Power',
    //     style: TextStyle(color: Colors.white),
    //   ),
    // ),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kTextFieldFill,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).primaryColor,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).primaryColor,
              color: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                const GButton(
                  icon: LineIcons.lightbulb,
                  text: 'Light',
                ),
                const GButton(
                  icon: LineIcons.userTag,
                  text: 'Power',
                ),
                const GButton(
                  icon: Icons.settings,
                  text: 'Setting',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
