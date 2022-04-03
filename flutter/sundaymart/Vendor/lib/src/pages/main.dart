import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/pages/dashboard.dart';
import 'package:vendor/src/pages/delivery_boy.dart';
import 'package:vendor/src/pages/orders.dart';
import 'package:vendor/src/pages/pos_system.dart';
import 'package:vendor/src/pages/product.dart';
import 'package:vendor/src/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProductController productController = Get.put(ProductController());
  OrderController orderController = Get.put(OrderController());

  final iconList = <List<IconData>>[
    [
      const IconData(0xecf1, fontFamily: 'MIcon'),
      const IconData(0xecf0, fontFamily: 'MIcon')
    ],
    [
      const IconData(0xf03d, fontFamily: 'MIcon'),
      const IconData(0xf03c, fontFamily: 'MIcon')
    ],
    [
      const IconData(0xf116, fontFamily: 'MIcon'),
      const IconData(0xf115, fontFamily: 'MIcon')
    ],
    [
      const IconData(0xf274, fontFamily: 'MIcon'),
      const IconData(0xf273, fontFamily: 'MIcon')
    ],
  ];
  final titleList = <String>[
    "Orders",
    "POS system",
    "Products",
    "Delivery boy",
  ];
  var _bottomNavIndex = 4;

  Widget renderBody(BuildContext context) {
    if (_bottomNavIndex == 0) {
      orderController.getOrders(1);
      return Orders(
        openDrawer: () {
          scaffoldKey.currentState!.openDrawer();
        },
      );
    } else if (_bottomNavIndex == 1) {
      productController.loadData.value = true;
      return PosSystem(
        openDrawer: () {
          scaffoldKey.currentState!.openDrawer();
        },
      );
    } else if (_bottomNavIndex == 2) {
      productController.loadData.value = true;
      productController.getProducts();
      return Products(
        openDrawer: () {
          scaffoldKey.currentState!.openDrawer();
        },
      );
    } else if (_bottomNavIndex == 3) {
      return DeliveryBoy(
        openDrawer: () {
          scaffoldKey.currentState!.openDrawer();
        },
      );
    }
    return Dashboard(
      openDrawer: () {
        scaffoldKey.currentState!.openDrawer();
      },
      changeTab: (index) {
        setState(() {
          _bottomNavIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromRGBO(236, 239, 243, 1),
      body: renderBody(context),
      drawer: SizedBox(
        width: 1.sw,
        child: Drawer(
          child: Profile(),
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(
            color: _bottomNavIndex == 4
                ? HexColor("#16AA16")
                : HexColor("#2E3456"),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: const Offset(0, 20),
                  blurRadius: 22,
                  spreadRadius: 0,
                  color: _bottomNavIndex == 4
                      ? const Color.fromRGBO(22, 170, 22, 0.3)
                      : const Color.fromRGBO(46, 52, 86, 0.3))
            ],
            borderRadius: BorderRadius.circular(66)),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          elevation: 0.0,
          child: Icon(
            const IconData(0xec13, fontFamily: 'MIcon'),
            color: HexColor("#ffffff"),
            size: 26.sp,
          ),
          onPressed: () {
            setState(() {
              _bottomNavIndex = 4;
            });
          },
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? HexColor('#16AA16')
              : const Color.fromRGBO(0, 0, 0, 0.3);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index][isActive ? 1 : 0],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Text(
                titleList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                    letterSpacing: -0.2),
              ),
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        leftCornerRadius: 12,
        rightCornerRadius: 12,
        height: 80,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: HexColor("#FFFFFF"),
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
