import 'package:flutter/material.dart';

class tField {
  static late String? WN;
  static late String dc;
  static late String? Cat;
  static late String? amt;
}

class transaction {
  late String? WalleName;
  late String? DC;
  late String? Category;
  late String? Amount;

  transaction({this.WalleName, this.DC, this.Category, this.Amount});

  static transaction? fromJson(Map<String, Object?> json) => transaction(
      DC: json['DC'].toString() as String,
      Category: json['CATEGORY'].toString() as String,
      Amount: json['AMOUNT'] as String);
}

class wField {
  static late String wn;
  static late String amt;
}

class wallet {
  late String walletname;
  late String amount;

  wallet(this.walletname, this.amount);

  static wallet fromJson(Map<String, Object?> json) =>
      wallet(json['WNAME'] as String, json['AMOUNT'] as String);
}
