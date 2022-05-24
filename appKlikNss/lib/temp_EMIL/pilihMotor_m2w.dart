import 'package:flutter/material.dart';

class PilihMotorM2W extends StatefulWidget {
  const PilihMotorM2W({Key? key}) : super(key: key);

  @override
  _PilihMotorM2WState createState() => _PilihMotorM2WState();
}

class _PilihMotorM2WState extends State<PilihMotorM2W> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Motor Jaminan"),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text("Motor", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12,),
          // TODO choose motor details
          _buildDropdownField("Merk", ["Honda, Ducati"]),
          _buildDropdownField("Series", ["Best Street"]),
          _buildDropdownField("Tipe", ["Beat Street ISS"]),
          _buildDropdownField("Tahun", ["2015","2016","2017"]),
          _buildDropdownField("Kepemilikan", ["Milik Pribadi","Pasangan","Orang Tua"]), // TODO match with spec
          // Text("Kepemilikan"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () {},
              child: Text("Gunakan Motor Ini"))
        ],
      ),
    );
  }

  Widget _buildDropdownField(String name, List<String> options) {

    String dropdownvalue = options[0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          Row(
            children: [
              SizedBox(width: 20,),
              DropdownButton(
                  value: dropdownvalue,
                  items: options.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  }),
            ],
          )
        ]
      ),
    );
  }
}
