import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/app/contants/custom_color.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  // List<Widget> pages = const [
  //   Text('eco', style: _textStyle),
  //   Text('home', style: _textStyle),
  //   Text('person', style: _textStyle),
  //   Text('video', style: _textStyle),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: BottomAppBar(
          child: NavigationBar(
            selectedIndex: _currentIndex,
            backgroundColor: CustomColor.backgroundGrayColor,
            onDestinationSelected: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                  size: 32.0,
                ),
                label: 'Home',
                icon: Icon(
                  Icons.home_outlined,
                  size: 32.0,
                ),
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.motorcycle,
                  color: Colors.red,
                  size: 32.0,
                ),
                icon: Icon(
                  Icons.motorcycle_outlined,
                  size: 32.0,
                ),
                label: 'Motor',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.money,
                  color: Colors.red,
                  size: 32.0,
                ),
                icon: Icon(
                  Icons.money_outlined,
                  size: 32.0,
                ),
                label: 'Pembiayaan',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.settings,
                  color: Colors.red,
                  size: 32.0,
                ),
                icon: Icon(
                  Icons.settings_outlined,
                  size: 32.0,
                ),
                label: 'Sparepart',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.list,
                  color: Colors.red,
                  size: 32.0,
                ),
                icon: Icon(
                  Icons.list,
                  size: 32.0,
                ),
                label: 'Menu Utama',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
