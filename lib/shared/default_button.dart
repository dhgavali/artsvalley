import 'package:artsvalley/helper/sizeconfig.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.width,
  }) : super(key: key);
  final String text;
  final Function press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(kcrimson),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
