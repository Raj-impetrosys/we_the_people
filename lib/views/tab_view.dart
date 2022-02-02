import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wethepeople/views/homepage.dart';
import 'package:wethepeople/views/query.dart';
import 'contact.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int index = 1;
  List<Widget> screens = [
    const Query(),
    const HomePage(),
    const Contact(),
  ];
  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.black;
    return Scaffold(
      body: Center(
          child: TextButton(
        child: screens[index],
        onPressed: () => Navigator.of(context).pushNamed('/bar'),
      )),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.cyanAccent,
        color: iconColor,
        style: TabStyle.react,
        items: const [
          TabItem(
            icon: Icons.message,
          ),
          TabItem(icon: Icons.home),
          TabItem(
            icon: Icons.phone,
          ),
        ],
        initialActiveIndex: 1,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
      ),
    );
  }
}
