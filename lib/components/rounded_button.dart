import 'package:flutter/material.dart';
import 'package:artsvalley/shared/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(29.0)),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20.0),
      ),
    );
  }
}
