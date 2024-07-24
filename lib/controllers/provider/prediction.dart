import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class MyPredictionProvider with ChangeNotifier {

  //data come from dermascopy data model
  var image;
  static var bcc = "";
  static var akiec = "";
  static var nv = "";
  static var mel = "";
  static var vasc = "";
  static var df = "";
  static var bkl = "";
  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }

  // data come from camera data model

  static var ak_bcc = "";
  static var eczema = "";
  static var nf = "";
  static var plp = "";
  static var sk = "";
  static var tr = "";
  static var wm = "";

  static var modelData = "";

}