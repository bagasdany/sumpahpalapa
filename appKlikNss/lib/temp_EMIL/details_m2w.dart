import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobileapps/temp_EMIL/form_m2w.dart';

class M2wDetails extends StatefulWidget {
  const M2wDetails({Key? key}) : super(key: key);

  @override
  _M2wDetailsState createState() => _M2wDetailsState();
}

class _M2wDetailsState extends State<M2wDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("details"),),
      body: Container(
        child: Column( // TODO replace placeholders
          children: [
            SizedBox(height: 20,),
            Text("This is the details page"),
            Expanded(child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("https://m.media-amazon.com/images/I/61uFesHn4BS._AC_SL1500_.jpg"),
                          fit: BoxFit.contain)),
                ),
              ],
            )),
            Text("Motorcycle name"),
            Text("Motorcycle price"),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => M2wForm())
                    ),
                    child: Text("Ajukan pinjaman"),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
