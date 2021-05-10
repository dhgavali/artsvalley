import 'package:flutter/material.dart';
import 'package:artsvalley/shared/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color bgcolor;
  const TextFieldContainer({Key key, this.child, this.bgcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: bgcolor ?? kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
