import 'package:get/get.dart';
import 'package:vendor/src/pages/address_add.dart';
import 'package:vendor/src/pages/addresses.dart';
import 'package:vendor/src/pages/brands.dart';
import 'package:vendor/src/pages/brands_add.dart';
import 'package:vendor/src/pages/brands_category.dart';
import 'package:vendor/src/pages/brands_category_add.dart';
import 'package:vendor/src/pages/brands_list.dart';
import 'package:vendor/src/pages/cart_detail.dart';
import 'package:vendor/src/pages/categories.dart';
import 'package:vendor/src/pages/category_add.dart';
import 'package:vendor/src/pages/category_tax_add.dart';
import 'package:vendor/src/pages/client_add.dart';
import 'package:vendor/src/pages/clients.dart';
import 'package:vendor/src/pages/delivery_boy_edit.dart';
import 'package:vendor/src/pages/delivery_boy_map.dart';
import 'package:vendor/src/pages/delivery_boy_order_list.dart';
import 'package:vendor/src/pages/language_init.dart';
import 'package:vendor/src/pages/loading.dart';
import 'package:vendor/src/pages/lost_connection.dart';
import 'package:vendor/src/pages/main.dart';
import 'package:vendor/src/pages/order_add.dart';
import 'package:vendor/src/pages/order_detail.dart';
import 'package:vendor/src/pages/product_add.dart';
import 'package:vendor/src/pages/product_character_add.dart';
import 'package:vendor/src/pages/product_extra_add.dart';
import 'package:vendor/src/pages/product_extra_group_add.dart';
import 'package:vendor/src/pages/shop_add.dart';
import 'package:vendor/src/pages/shop_box_add.dart';
import 'package:vendor/src/pages/shop_delivery_add.dart';
import 'package:vendor/src/pages/shop_transport_add.dart';
import 'package:vendor/src/pages/shops.dart';
import 'package:vendor/src/pages/sign_in.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => const Loading()),
    GetPage(name: '/home', page: () => const MainPage()),
    GetPage(
        name: '/signin',
        page: () => const SignInPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/orderDetail',
        page: () => const OrderDetail(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/orderAdd',
        page: () => const OrderAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brands',
        page: () => const Brands(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brandsAdd',
        page: () => const BrandsAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brandsCategory',
        page: () => const BrandsCategory(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brandsCategoryAdd',
        page: () => const BrandsCategoryAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brandsList',
        page: () => const BrandsList(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/brandsAdd',
        page: () => const BrandsAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/categories',
        page: () => const Category(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/categoryAdd',
        page: () => const CategoryAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/productAdd',
        page: () => const ProductAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/categoryTaxAdd',
        page: () => const CategoryTaxAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/cartDetail',
        page: () => const CartDetail(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/shops',
        page: () => const Shops(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/shopsAdd',
        page: () => const ShopAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/deliveryBoyOrderList',
        page: () => const DeliveryBoyOrderList(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/deliveryBoyEdit',
        page: () => const DeliveryBoyEdit(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/deliveryBoyMap',
        page: () => const DeliveryBoyMap(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/shopDeliveryAdd',
        page: () => const ShopDeliveryAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/shopTransportAdd',
        page: () => const ShopTransportAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/shopBoxAdd',
        page: () => const ShopBoxAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/productCharacterAdd',
        page: () => const ProductCharactersAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/productExtraGroupAdd',
        page: () => const ProductExtrasGroupAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/productExtraAdd',
        page: () => const ProductExtraAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/clients',
        page: () => const Clients(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/clientAdd',
        page: () => const ClientAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/address',
        page: () => const Addresses(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: '/addressAdd',
        page: () => const AddressAdd(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(name: '/languageInit', page: () => const LanguageInit()),
    GetPage(name: '/noConnection', page: () => const LostConnection()),
  ];
}
