import 'package:flutter/widgets.dart';

class Mypredection_provider with ChangeNotifier{
  var image;
  static String normal="";
  static String mild="";
  static String moderate="";
  static String severe="";
  static String poliferative="";
  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }
}