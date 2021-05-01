import 'package:flutter/material.dart';
import 'package:artsvalley/shared/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final double hpadding;
  final double width;
  const RoundedButton({
    Key key,
    this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.hpadding = 40.00,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: (width == null) ? size.width * 0.8 : width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(29.0)),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: hpadding),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20.0),
      ),
    );
  }
}
