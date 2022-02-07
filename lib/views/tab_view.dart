import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wethepeople/globals/app_constants.dart';
import 'package:wethepeople/globals/functions/on_back_button_pressed.dart';
import 'package:wethepeople/services/firebase/firebase.dart';
import 'package:wethepeople/views/homepage.dart';
import 'package:wethepeople/views/notification.dart';
import 'package:wethepeople/views/query.dart';
import 'contact.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  List<Widget> screens = [
    const NotificationPage(),
    const HomePage(),
    const Contact(),
  ];

  @override
  void initState() {
    firebase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.black;
    return WillPopScope(
      onWillPop: () {
        return onBackButtonPressed(context);
      },
      child: Scaffold(
        body: Center(
            child: TextButton(
          child: screens[Constants.index],
          onPressed: () => Navigator.of(context).pushNamed('/bar'),
        )),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.brown,
          color: iconColor,
          style: TabStyle.react,
          items: const [
            TabItem(
              icon: Icons.notifications_active,
            ),
            TabItem(icon: Icons.home),
            TabItem(
              icon: Icons.phone,
            ),
          ],
          initialActiveIndex: 1,
          onTap: (int i) {
            setState(() {
              Constants.index = i;
            });
          },
        ),
      ),
    );
  }
}
