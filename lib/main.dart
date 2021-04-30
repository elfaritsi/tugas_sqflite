import 'package:flutter/material.dart';
import 'package:tugas_sqflite_daeng_6sia4/karyawan.dart';
import 'package:tugas_sqflite_daeng_6sia4/MySqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nama = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  List<Karyawan> karyawan = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Daeng Mhd El Faritsi | 6SIA4"),
          brightness: Brightness.dark,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text("Input Data Karyawan", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                TextField(
                  controller: nama,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "nama",
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(
                      Icons.list_alt,
                      color: Colors.red,
                    ),
                    hintStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jabatan,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Jabatan",
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(
                      Icons.person_pin_circle_outlined,
                      color: Colors.red,
                    ),
                    hintStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red)),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _onSaveKaryawan();
                        },
                        child: Text("Simpan"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("Data Karyawan",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: karyawan.length,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (BuildContext context, int index) {
                      var value = karyawan[index];
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: .2))),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 50,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nama        :  ${value.name}"),
                                  Text("Jabatan    :  ${value.position}")
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSaveKaryawan() async {
    await MySqflite.instance
        .insertKaryawan(Karyawan(name: nama.text.trim(), position: jabatan.text.trim()));
    nama.text = "";
    jabatan.text = "";
    karyawan = await MySqflite.instance.getKaryawan();
    setState(() {});
  }
}
