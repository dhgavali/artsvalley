import 'package:flutter/material.dart';

Widget customInputField(String hintText, Icon customIcon) {
  Icon myIcon = customIcon;
  String hint = hintText;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        suffixIcon: myIcon,
        labelText: hint,
        contentPadding: EdgeInsets.only(left: 25),
      ),
    ),
  );
}

Widget loginButton(String btnText) {
  return Container(
    width: 160,
    height: 50,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        btnText,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}
