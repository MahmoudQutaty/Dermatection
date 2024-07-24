import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';


Widget myTextField({
  required TextEditingController controller,
  required TextInputType type,
  required label,
  required IconData prefix,
  bool obscureText=false,
  required Function validate,

}) => TextFormField(
  validator:validate(),
  obscureText: obscureText,
  controller: controller,
  keyboardType: type,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[500]),
),
);