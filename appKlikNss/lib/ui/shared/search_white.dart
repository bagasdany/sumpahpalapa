import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/contants/custom_color.dart';
import 'package:mobileapps/ui/shared/AppbarGradient.dart';
import 'package:mobileapps/ui/views/home/home_view.dart';

import '../component/pencarian_component.dart';
import '../component/rekomendasi_motor_component.dart';

class searchAppbar extends StatefulWidget {
  @override
  _searchAppbarState createState() => _searchAppbarState();
}

class _searchAppbarState extends State<searchAppbar> {
  @override
  Widget build(BuildContext context) {
    /// Sentence Text header "Hello i am Treva.........."

    /// Item TextFromField Search
    Widget SearchBar() {
      return Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
            color: CustomColor.backgroundGrayColor,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: CustomColor.backgroundGrayColor,
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Theme(
              data: ThemeData(hintColor: CustomColor.primaryWhiteColor),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, const HomeView());
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColor.primaryBlackColor,
                      size: 26.0,
                    ),
                  ),
                  hintText: ('Masukkan kata kunci pencarian...'),
                  hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      );
    }

    /// Item Favorite Item with Card item
    Widget rekomendasiItem() {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  ('favorite'),
                  style: TextStyle(fontFamily: "Gotik", color: Colors.black26),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 2.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      );
    }

    /// Popular Keyword Item
    Widget rekomendasitext() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: CustomColor.backgroundGrayColor,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                child: Text(
                  ('Pencarian Terakhir'),
                  style: TextStyle(
                      fontFamily: "Gotik",
                      color: CustomColor.primaryBlackColor,
                      fontSize: 16,
                      fontWeight: bold),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 0.0)),
            Expanded(
                child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                  ),
                ),
                KeywordItem(
                  title: ('searchTitle1'),
                ),
                KeywordItem(
                  title: ('searchTitle3'),
                ),
                KeywordItem(
                  title: ('searchTitle5'),
                  // title2: ('searchTitle6'),
                ),
                KeywordItem(
                  title: ('searchTitle7'),
                  // title2: ('searchTitle8'),
                ),
              ],
            ))
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Caliing a variable
              // _textHello,
              // AppbarGradient(),
              SearchBar(),
              rekomendasitext(),
              rekomendasiItem(),
              // const Padding(
              //     padding: const EdgeInsets.only(bottom: 30.0, top: 2.0))
            ],
          ),
        ),
      ),
    );
  }
}