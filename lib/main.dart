import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'sec.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: myApp()));
}

class myApp extends StatefulWidget {
  myApp({Key? key}) : super(key: key) {}

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20, color: Colors.amber, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.amber),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      WDb = await WalletDB.init();
      dynamic v = await WDb.WDB;
      Db = await TransactionDB.init();
      dynamic f = await Db.DB;
    }
  }

  void initState() {
    super.initState();
    _getStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    nextpage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 350),
            child: Text(
              "Enter Pin",
              style: TextStyle(fontSize: 35, color: Colors.amber),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Pinput(
              defaultPinTheme: defaultPinTheme,
              validator: (s) {
                return s == '2222' ? nextpage() : "Pin is incorrect";
              },
            ),
          )
        ],
      )),
      backgroundColor: Colors.black,
    );
  }
}
