import 'package:flutter/material.dart';
import 'package:mobileapps/temp_EMIL/pilihMotor_m2w.dart';

class M2wForm extends StatefulWidget {
  const M2wForm({Key? key}) : super(key: key);

  @override
  _M2wFormState createState() => _M2wFormState();
}

class _M2wFormState extends State<M2wForm> {
  final _formKey = GlobalKey<FormState>();

  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form")),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(child: _buildForm())),
    );
  }

  Widget _buildForm() {
    // Form contain fields for

    DateTime now = DateTime.now();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 120),
          Container(
            padding: const EdgeInsets.all(12.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Multiguna Motor',
                style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Pelajari")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(

                // mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO build form components

                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Mohon isi NIK';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'NIK',
                  //   ),
                  // ),
                  //
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Mohon isi alamat';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'Alamat',
                  //   ),
                  // ),

                  SizedBox(height:24),
                  _buildMotorJaminan(),
                  SizedBox(height:24),
                  _buildSimulasiPengajuan()
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMotorJaminan() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Motor Jaminan"),
          InkWell( // TODO find out inkwell vs gesturedetector
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Pilih motor"), Icon(Icons.arrow_forward_ios)],
              ),
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PilihMotorM2W())),
          )
        ],
      ),
    );
  }

  Widget _buildSimulasiPengajuan() {


    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Text("Simulasi Pengajuan"),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jumlah yang dibutuhkan"),
                    // TODO Price indicator, replace placeholder
                    Text("Motor belum dipilih")
                  ],
                ),
                // TODO adjust to actual
                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                SizedBox(height: 12,),
                Text("Tenor:"),
                // TODO buttons for cicil settings (berapa kali cicilan,
                Row(children: [
                  TextButton(
                      onPressed: () => print("press cicil settings"),
                      child: Text("11x")),
                  TextButton(
                      onPressed: () => print("press cicil settings"),
                      child: Text("17x")),
                  TextButton(
                      onPressed: () => print("press cicil settings"),
                      child: Text("23x")),
                  TextButton(
                      onPressed: () => print("press cicil settings"),
                      child: Text("29x")),
                  TextButton(
                      onPressed: () => print("press cicil settings"),
                      child: Text("35x")),
                ],),
                SizedBox(height: 12,),
                Text("Voucher:"),
                // TODO Voucher button,
                TextButton(
                    onPressed: () => print("Voucher pressed!"),
                    child: Text("Gunakan Voucher")),
                SizedBox(height: 24,),
                  ],
                ),
            Row(
              children: [
                // TODO adjust onPressed actions
                ElevatedButton(
                    onPressed: () => print("Chat!"),
                    child: Icon(Icons.chat)),
                SizedBox(width: 24,),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => print("Buat Pengajuan!"),
                      child: Text("Buat Pengajuan")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
