import 'package:artsvalley/shared/constants.dart';
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
    String hintText, IconData customIcon, TextEditingController mycontroller,
    [bool obsecureText = false]) {
  Icon myIcon = Icon(customIcon, color: Colors.white70);
  String hint = hintText;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
    child: TextFormField(
      controller: mycontroller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: () {
            obsecureText ? obsecureText = false : obsecureText = true;
          },
          child: myIcon,
        ),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white70),
        contentPadding: EdgeInsets.only(left: 25),
      ),
    ),
  );
}

Widget loginButton(String btnText, Function onpress, String emailController,
    String passwordController) {
  return Container(
    width: ProConstants.buttonWidth,
    height: ProConstants.buttonHeight,
    child: ElevatedButton(
      onPressed: onpress,
      child: Text(
        btnText,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}
