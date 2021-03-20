import 'package:flutter/material.dart';

class BoxContent extends StatelessWidget {
  final String textInside;
  final int numvalue;
  BoxContent({this.textInside, this.numvalue});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 100) / 3,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textInside,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            numvalue.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

Widget customInputField(
    String hintText, Icon customIcon, TextEditingController mycontroller) {
  Icon myIcon = customIcon;
  String hint = hintText;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
    child: TextField(
      controller: mycontroller,
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

Widget loginButton(String btnText, Function onpress) {
  return Container(
    width: 160,
    height: 50,
    child: ElevatedButton(
      onPressed: onpress,
      child: Text(
        btnText,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}
