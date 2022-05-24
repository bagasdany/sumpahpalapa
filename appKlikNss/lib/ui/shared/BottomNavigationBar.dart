import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobileapps/ui/views/home/home_view.dart';

import '../../application/app/contants/custom_color.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return const HomeView();
      case 1:
        return const HomeView();
      case 2:
        return const HomeView();
      case 3:
        return const HomeView();
      case 4:
        return const HomeView();
      default:
        return HomeView();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    // var data = EasyLocalizationProvider.of(context)!.data;
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.black12))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          fixedColor: CustomColor.primaryRedColor,
          unselectedItemColor: CustomColor.primaryBlackColor,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            // const BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.home,
            //       size: 19.0,
            //     ),
            //     label: ('home')),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.motorcycle_rounded),
            //   label: ('Motor'),
            // ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 19.0,
                ),
                label: ('home')),
            const BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle_rounded),
              label: ('Motor'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.monetization_on,
                size: 19.0,
              ),
              label: ('Pembiayaan'),
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ('Sparepart'),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: ('Menu\nUtama'),
            ),
            // BottomNavigationBarItem(
            //     icon: SvgPicture.asset(
            //       'assets/img/pembiayaan.svg',
            //       width: 26,
            //       height: 26,
            //     ),
            //     label: ('cart')),
            // BottomNavigationBarItem(
            //     icon: SvgPicture.asset(
            //       'assets/img/gears.svg',
            //       width: 26,
            //       height: 26,
            //     ),
            //     label: ('Sparepart')),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/img/bars.svg',
            //     width: 26,
            //     height: 26,
            //   ),
            //   label: ('Menu\nUtama'),
            // ),
          ],
        ),
      ),
    );
  }
}