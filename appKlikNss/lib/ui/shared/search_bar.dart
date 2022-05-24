import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController? searchController;
  final String? svgIcon;
  final String? hintText;
  const SearchBar(
      {Key? key, this.searchController, this.svgIcon, this.hintText})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      automaticallyImplyBackButton: true,
      hint: "Cari di KlikNSS",
      openAxisAlignment: 0.0,
      backgroundColor: CustomColor.primaryWhiteColor,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) {
        //Your methods will be here
      },
      // showDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: Row(
            children: [],
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: CustomColor.primaryWhiteColor,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: CustomColor.primaryWhiteColor,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const ListTile(
                    title: Text('Home'),
                    subtitle: Text('more info here........'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
