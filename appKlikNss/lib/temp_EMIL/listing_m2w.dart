import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/application/app/app.router.dart';
import 'package:mobileapps/temp_EMIL/details_m2w.dart';

class M2wListing extends StatefulWidget {
  const M2wListing({Key? key}) : super(key: key);

  @override
  _M2wListingState createState() => _M2wListingState();
}

class _M2wListingState extends State<M2wListing> {
  final List<Motorcycle> motorcycles = [Motorcycle("yamaha", "399.000")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembiayaan Motor")),
      body: Column(
        children: [Container(
            height: 50,
            alignment: Alignment.center,
            child: Text("helloooo this is the listing page"),
        ), _buildList()],
      ),
    );
  }

  Widget _buildList() {

    // motorItem(viewModel.homeEntityModel!.sections![3].items![index]);
    // TODO must find way to retrieve motorcycledata

    return SizedBox(
      height: 600,
      child: Card(child: ListView.builder(
        itemCount: 5, // motorcycles.length, 20
          itemBuilder: (context, index) {
        // final Motorcycle motorcycle = motorcycles[index];

        return Column(
          children: [
            SizedBox(
              height:166,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => M2wDetails())
                ),
                child: Card(
                  child: Stack(
                    children: [
                      Container(
                          // child: Text("motorcycle photo here"),
                        padding: EdgeInsets.all(52),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider("https://m.media-amazon.com/images/I/61uFesHn4BS._AC_SL1500_.jpg"),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                          child: Text("Motorcycle name"),
                          alignment: Alignment.bottomLeft,
                      ),
                      Container(
                          child: Text("Motorcycle price"),
                          alignment: Alignment.bottomRight,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider()
          ],
        );
      })),
    );
  }
}

// TODO move to its own model class

class Motorcycle {
  final String? motorcycleName;
  final String? price;

  Motorcycle(this.motorcycleName, this.price);

}