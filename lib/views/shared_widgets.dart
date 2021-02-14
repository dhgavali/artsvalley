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
