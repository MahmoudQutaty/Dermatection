import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

Widget myButton({
  String title='',
  Color background = kPrimaryColor,
  double width=double.infinity,
  double height=60.0,
  required VoidCallback? function,
})=> Padding(

  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
  child:   Container(
    decoration: BoxDecoration(

      color: kTextColor,

      borderRadius: BorderRadius.circular(10),

    ),

    height: height,

    width: width,

    child: MaterialButton(

      onPressed: function,

      child: Text(title ,

        style: const TextStyle(

        color: Colors.white,

        ),

      ),

    ),

  ),
);